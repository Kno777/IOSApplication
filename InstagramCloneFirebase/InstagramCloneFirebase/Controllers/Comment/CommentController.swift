//
//  CommentController.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 03.08.23.
//

import UIKit
import Firebase

class CommentController: UICollectionViewController, UICollectionViewDelegateFlowLayout, CustomInputAccessoryViewDelegate {
    
    func didSubmit(for comment: String) {
        print("Inserting comment: ", comment)
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let postId = self.post?.id else { return }
        
        let values = ["text": comment, "creationDate": Date().timeIntervalSince1970, "uid": uid] as [String: Any]
        
        Database.database().reference().child("comments").child(postId).childByAutoId().updateChildValues(values) { err, ref in
            
            if let err = err {
                print("Failed to add comments: ", err)
                return
            }
            
            print("Successfully added user comments")
            
            self.containerView.clearCommentWhenSuccessued()
        }
    }
    
    
    var post: UserPostModel?
    var comments: [CommentModel] = []
    
    lazy var containerView: CustomInputAccessoryView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let customInputAccessoryView = CustomInputAccessoryView(frame: frame)
        customInputAccessoryView.delegate = self
        return customInputAccessoryView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Comments"
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
        
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: HeaderAndCell.cellId)
        
        fetchComments()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    override var inputAccessoryView: UIView? {
        return containerView
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.comments.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderAndCell.cellId, for: indexPath) as! CommentCell
        
        cell.comment = self.comments[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        
        let dummyCell = CommentCell(frame: frame)
        dummyCell.comment = self.comments[indexPath.item]
        dummyCell.layoutIfNeeded()
        
        let targetSize = CGSize(width: view.frame.width, height: 1000)
        let estimatedSize = dummyCell.systemLayoutSizeFitting(targetSize)
        
        let height = max(40 + 8 + 8, estimatedSize.height)
        return CGSize(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    fileprivate func fetchComments() {
        
        guard let postId = post?.id else { return }
        
        let ref = Database.database().reference().child("comments").child(postId)
        
        ref.observe(.childAdded) { snapshot in
            
            guard let dictionaryComment = snapshot.value as? [String: Any] else { return }
            
            guard let uid = dictionaryComment["uid"] as? String else { return }
            
            Database.fetchUserWithUID(uid: uid) { user in
                
                let comment = CommentModel(user: user, dictionary: dictionaryComment)
                            
                self.comments.append(comment)
                
                self.collectionView.reloadData()
            }
            
            
        } withCancel: { err in
            print("Failed to fetch comments: ", err)
        }
    }
}

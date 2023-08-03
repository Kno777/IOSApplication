//
//  CommentController.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 03.08.23.
//

import UIKit
import Firebase

class CommentController: UICollectionViewController {
    
    var post: UserPostModel?
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        
        let submitButton = UIButton(type: .system)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitleColor(.systemBlue, for: .normal)
        submitButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        submitButton.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        
        containerView.addSubview(submitButton)
        submitButton.anchor(top: containerView.topAnchor, left: nil, bottom: containerView.bottomAnchor, right: containerView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: -12, width: 50, height: 0)
        
        containerView.addSubview(self.commentTextField)
        self.commentTextField.anchor(top: containerView.topAnchor, left: containerView.leadingAnchor, bottom: containerView.bottomAnchor, right: submitButton.leadingAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        return containerView
    }()
    
    let commentTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Comment"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    @objc private func handleSubmit() {
        print("Inserting comment: ", self.commentTextField.text ?? "")
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let postId = self.post?.id else { return }
        
        let values = ["text": commentTextField.text ?? "", "creationDate": Date().timeIntervalSince1970, "uid": uid] as [String: Any]
        
        Database.database().reference().child("comments").child(postId).childByAutoId().updateChildValues(values) { err, ref in
            
            if let err = err {
                print("Failed to add comments: ", err)
                return
            }
            
            print("Successfully added user comments")
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Comments"
        collectionView.backgroundColor = .systemPink

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
}

//
//  HomeController.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 31.07.23.
//

import UIKit
import Firebase

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var posts: [UserPostModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(HomePostCell.self, forCellWithReuseIdentifier: HeaderAndCell.cellId)
        
        setupNaviagtionItems()
        
        fetchPosts()
    }
    
    fileprivate func fetchPosts() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        // MARK: - fetch users
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { snapshot in
            
            guard let userDict = snapshot.value as? [String: Any] else { return }
            
            let user = User(dictionary: userDict)
            
            // MARK: - fetch posts
            Database.database().reference().child("posts").child(uid).observeSingleEvent(of: .value) { snapshot in
                
                guard let dictionaries = snapshot.value as? [String: Any] else { return }

                dictionaries.forEach { (key, value) in
                    
                    guard let dictionary = value as? [String: Any] else { return }
                                                        
                    let post = UserPostModel(user: user, dictonary: dictionary)
                    
                    self.posts.append(post)
                }
                
                self.collectionView.reloadData()
                
            } withCancel: { err in
                print("Failed to fetch posts from DB.", err)
            }
            
            
            
        } withCancel: { err in
            print("Failed to fetch user from DB.", err)
            return
        }
    }
    
    fileprivate func setupNaviagtionItems() {
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo2"))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 40 + 8 + 8 // usernameLable and userProfileImageView
        height += view.frame.width
        height += 50 // photoImage bottom toolbar
        height += 60 // username + post text and when posted // creation date
        return CGSize(width: view.frame.width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderAndCell.cellId, for: indexPath) as! HomePostCell
        
        cell.post = self.posts[indexPath.item]

        return cell
    }
    
}

//
//  UserProfileController.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 27.07.23.
//

import UIKit
import Firebase

class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var user: User?
    var posts: [UserPostModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        navigationItem.title = Auth.auth().currentUser?.uid
        
        setupNavigationStyle()
        
        fetchUser()
        
        
        collectionView.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderAndCell.headerId)
        
        collectionView.register(UserProfilePostsCell.self, forCellWithReuseIdentifier: HeaderAndCell.cellId)
        
        setupLogOutButton()
        
        //fetchPosts()
        
        fetchOrderedPosts()
    }
    
    @objc func handelLogOut() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            
            do {
                try Auth.auth().signOut()
                
                let loginController = LoginController()
                let navigationController = UINavigationController(rootViewController: loginController)
                navigationController.modalPresentationStyle = .fullScreen
                self.present(navigationController, animated: true)
                
            } catch {
                print("Failed to user log out: ", error)
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alertController, animated: true)
    }
    
    fileprivate func fetchOrderedPosts() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let ref = Database.database().reference().child("posts").child(uid)
        
        // perhaps later on we'll implement some pagination of data
        ref.queryOrdered(byChild: "creationDate").observe(.childAdded) { snapshot in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            
            guard let user = self.user else { return }
            let post = UserPostModel(user: user, dictonary: dictionary)
            
            self.posts.insert(post, at: 0)
            //self.posts.append(post)
            
            self.collectionView.reloadData()
            
        } withCancel: { err in
            print("Failed to fetch posts from DB.", err)
        }
    }
    
    fileprivate func fetchPosts() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("posts").child(uid).observeSingleEvent(of: .value) { snapshot in
            
            guard let dictionaries = snapshot.value as? [String: Any] else { return }

            dictionaries.forEach { (key, value) in
                
                guard let dictionary = value as? [String: Any] else { return }
                
                guard let user = self.user else { return }
                                
                let post = UserPostModel(user: user, dictonary: dictionary)
                
                self.posts.append(post)

            }
            
            self.collectionView.reloadData()
            
        } withCancel: { err in
            print("Failed to fetch posts from DB.", err)
        }
    }
    
    fileprivate func setupLogOutButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "gear"), style: .plain, target: self, action: #selector(handelLogOut))
    }
    
    fileprivate func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.fetchUserWithUID(uid: uid) { user in
            self.user = user
            
            self.navigationItem.title = self.user?.username
            
            self.collectionView.reloadData()
        }
    }
}

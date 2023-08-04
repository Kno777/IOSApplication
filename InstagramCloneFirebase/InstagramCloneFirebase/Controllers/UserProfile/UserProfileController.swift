//
//  UserProfileController.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 27.07.23.
//

import UIKit
import Firebase

class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UserProfileHeaderDelegate {
    
    var user: UserModel?
    var posts: [UserPostModel] = []
    var userId: String?
    var isGridView: Bool = true
    var isFinishedPaging: Bool = false
    
    func didChangeToListView() {
        isGridView = false
        self.collectionView.reloadData()
    }
    
    func didChangeToGridView() {
        isGridView = true
        self.collectionView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        navigationItem.title = Auth.auth().currentUser?.uid
        
        setupNavigationStyle()
        
        collectionView.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderAndCell.headerId)
        
        collectionView.register(UserProfilePostsCell.self, forCellWithReuseIdentifier: HeaderAndCell.cellId)
        
        collectionView.register(HomePostCell.self, forCellWithReuseIdentifier: HeaderAndCell.homePostCellIdForUserProfileListView)
        
        setupLogOutButton()
        
        fetchUser()
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
    
    func paginatePosts() {
        print("Start paging for more posts")
        
        guard let uid = self.user?.uid else { return }
        let ref = Database.database().reference().child("posts").child(uid)
        
        var query = ref.queryOrderedByKey()
        
        if self.posts.count > 0 {
            let values = self.posts.last?.id
            
            query = query.queryStarting(atValue: values)
        }
        
        query.queryLimited(toFirst: 4).observeSingleEvent(of: .value) { snapshot in
            
            guard let user = self.user else { return }
            
            guard var allObject = snapshot.children.allObjects as? [DataSnapshot] else { return }
            
            if allObject.count < 4 {
                self.isFinishedPaging = true
            }
            
            if self.posts.count > 0 {
                allObject.removeFirst()
            }
            
            allObject.forEach({ snapshot in
                
                guard let dictionary = snapshot.value as? [String: Any] else { return }
                                
                var post = UserPostModel(user: user, dictonary: dictionary)
                post.id = snapshot.key
                
                self.posts.append(post)
            })
            
            self.posts.forEach { post in
                print(post.id ?? "")
            }
            
            self.collectionView.reloadData()
            
        } withCancel: { err in
            print("Failed to fetch user posts.", err)
            return
        }
    }
    
    fileprivate func fetchOrderedPosts() {
        guard let uid = user?.uid else { return }
        
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
    
    fileprivate func fetchUser() {
        
        let uid = userId ?? Auth.auth().currentUser?.uid ?? ""
                
        Database.fetchUserWithUID(uid: uid) { user in
            self.user = user
            
            self.navigationItem.title = self.user?.username
            
            self.collectionView.reloadData()
            
            //self.fetchOrderedPosts()
            self.paginatePosts()
        }
    }
    
    fileprivate func setupLogOutButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "gear"), style: .plain, target: self, action: #selector(handelLogOut))
    }
}

//
//  HomeController.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 31.07.23.
//

import UIKit
import Firebase

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout, HomePostCellDelegate {
    
    
    func didTapLike(for cell: HomePostCell) {
        guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
        
        var post = self.posts[indexPath.item]
        
        guard let postId = post.id else { return }
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = [uid: post.hasLiked == true ? 0 : 1]
        
        Database.database().reference().child("likes").child(postId).updateChildValues(values) { err, ref in
            if let err = err {
                print("Failed to like post.", err)
                return
            }
            
            print("Successfully like post.")
            
            post.hasLiked = !post.hasLiked
            self.posts[indexPath.item] = post
            
            self.collectionView.reloadItems(at: [indexPath])
        }
    }
    
    
    func didTapComment(post: UserPostModel) {
        print("Comments called from HomeController")
        print("post: ", post.caption)
        
        let commentController = CommentController(collectionViewLayout: UICollectionViewFlowLayout())
        
        commentController.post = post
        
        navigationController?.pushViewController(commentController, animated: true)
    }
    
    
    var posts: [UserPostModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Notification Center for update home feed
        let name = NSNotification.Name(rawValue: NotificationCenterForUpdateHomeFeed.name)
        NotificationCenter.default.addObserver(self, selector: #selector(handelUpdateFeed), name: name, object: nil)
        
        collectionView.backgroundColor = .white
        
        collectionView.register(HomePostCell.self, forCellWithReuseIdentifier: HeaderAndCell.cellId)
        
        setupNaviagtionItems()
        
        fetchAllPosts()
        
        let refreshController = UIRefreshControl()
        refreshController.tintColor = .black
        refreshController.addTarget(self, action: #selector(handelRefreshPosts), for: .valueChanged)
        self.collectionView.refreshControl = refreshController
    }
    
    @objc private func handelCamera() {
        print("Showing camera...")
        
        let cameraController = CameraController()
        cameraController.modalPresentationStyle = .fullScreen
        present(cameraController, animated: true)
    }
    
    // MARK: - update home feed autommatically using NSNotification
    @objc private func handelUpdateFeed() {
        handelRefreshPosts()
    }
    
    @objc private func handelRefreshPosts() {
        fetchAllPosts()
    }
    
    fileprivate func fetchAllPosts() {
        posts.removeAll()
        
        fetchPosts()
        fetchUsersPostsByFollowingIds()
    }
    
    fileprivate func fetchUsersPostsByFollowingIds() {
        guard let currentUserUID = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("following").child(currentUserUID).observeSingleEvent(of: .value) { snapshot in
            
            guard let followedUserId = snapshot.value as? [String: Any] else { return}
            
            followedUserId.forEach { key, _ in
                
                Database.fetchUserWithUID(uid: key) { user in
                    self.fetchPostsWithUser(user: user)
                }
            }
            
        } withCancel: { err in
            print("Failed to fetch following users ids: ", err)
        }
    }
    
    fileprivate func fetchPosts() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.fetchUserWithUID(uid: uid) { user in
            // MARK: - fetch users
            self.fetchPostsWithUser(user: user)
        }
    }
    
    fileprivate func fetchPostsWithUser(user: UserModel) {
        // MARK: - fetch posts
        Database.database().reference().child("posts").child(user.uid).observeSingleEvent(of: .value) { snapshot in
                        
            self.collectionView.refreshControl?.endRefreshing()

            guard let dictionaries = snapshot.value as? [String: Any] else { return }

            dictionaries.forEach { (key, value) in
                
                guard let dictionary = value as? [String: Any] else { return }
                
                var post = UserPostModel(user: user, dictonary: dictionary)
                post.id = key
                
                guard let uid = Auth.auth().currentUser?.uid else { return }
                
                // MARK: - like logic
                Database.database().reference().child("likes").child(key).child(uid).observeSingleEvent(of: .value) { snapshot in
                    
                    if let postLiked = snapshot.value as? Int , postLiked == 1{
                        post.hasLiked = true
                    } else {
                        post.hasLiked = false
                    }
                    
                    self.posts.append(post)
                    self.posts.sort { p1, p2 in
                        return p1.creationDate.compare(p2.creationDate) == .orderedDescending
                    }
                    self.collectionView.reloadData()
                    
                } withCancel: { err in
                    print("Failed to fetch likes.", err)
                }
            }
        } withCancel: { err in
            print("Failed to fetch posts from DB.", err)
        }
    }
    
    fileprivate func setupNaviagtionItems() {
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo2"))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "camera3")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handelCamera))
    }
}

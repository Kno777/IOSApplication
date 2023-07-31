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
        
        Database.database().reference().child("posts").child(uid).observeSingleEvent(of: .value) { snapshot in
            
            guard let dictionaries = snapshot.value as? [String: Any] else { return }

            dictionaries.forEach { (key, value) in
                
                guard let dictionary = value as? [String: Any] else { return }
                                
                let post = UserPostModel(dictonary: dictionary)
                
                self.posts.append(post)

            }
            
            self.collectionView.reloadData()
            
        } withCancel: { err in
            print("Failed to fetch posts from DB.", err)
        }
    }
    
    fileprivate func setupNaviagtionItems() {
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo2"))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 200)
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

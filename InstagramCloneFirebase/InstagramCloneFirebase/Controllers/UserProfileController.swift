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
    
    let cellId = "cellId"
    
    let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        navigationItem.title = Auth.auth().currentUser?.uid
        
        setupNavigationStyle()
        
        fetchUser()
        
        
        collectionView.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        setupLogOutButton()
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
    
    fileprivate func setupLogOutButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "gear"), style: .plain, target: self, action: #selector(handelLogOut))
    }
    
    fileprivate func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { snapshot in
            
            print(snapshot.value ?? "")
            
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            self.user = User(dictionary: dictionary)
            
            self.navigationItem.title = self.user?.username
            
            self.collectionView.reloadData()
            
        } withCancel: { err in
            print("Failed to fetch user: ", err)
        }
    }
}

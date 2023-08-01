//
//  UserSearchController.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 01.08.23.
//

import UIKit
import Firebase

class UserSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var users: [User] = []
    var filteredUsers: [User] = []
    
    private lazy var searchBar: UISearchBar = {
       let search = UISearchBar()
        search.placeholder = "Enter username..."
        search.tintColor = .black
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .lightGray.withAlphaComponent(0.4)
        search.translatesAutoresizingMaskIntoConstraints = false
        
        search.delegate = self
        
        return search
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .onDrag
        
        navigationController?.navigationBar.addSubview(searchBar)
        
        searchBar.anchor(top: navigationController?.navigationBar.topAnchor, left: navigationController?.navigationBar.leadingAnchor, bottom: navigationController?.navigationBar.bottomAnchor, right: navigationController?.navigationBar.trailingAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: -8, width: 0, height: 0)
        
        collectionView.register(UserSearchCell.self, forCellWithReuseIdentifier: HeaderAndCell.cellId)
        
        fetchUser()
    }
    
    fileprivate func fetchUser() {
        print("Fetching user...")
        
        
        let ref = Database.database().reference().child("users")
        
        ref.observeSingleEvent(of: .value) { snapshot in
            guard let dictonaries = snapshot.value as? [String: Any] else { return }
            
            dictonaries.forEach { key, value in
                
                if key == Auth.auth().currentUser?.uid {
                    print("Found myself, omit from list")
                    return
                }
                
                guard let userDictonary = value as? [String: Any] else { return }
                
                let user = User(uid: key, dictionary: userDictonary)
                
                self.users.append(user)
            }
            
            self.users.sort { u1, u2 in
                return u1.username.compare(u2.username) == .orderedAscending
            }
            
            self.filteredUsers = self.users
            self.collectionView.reloadData()
            
        } withCancel: { err in
            print("Failed to fetch user for search.", err)
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            self.filteredUsers = self.users
        } else {
            self.filteredUsers = self.users.filter { user in
                return user.username.lowercased().contains(searchText.lowercased())
            }
        }
        
        self.collectionView.reloadData()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        searchBar.isHidden = true
        searchBar.resignFirstResponder()
        
        let user = self.filteredUsers[indexPath.item]
        
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        userProfileController.userId = user.uid
        navigationController?.pushViewController(userProfileController, animated: true)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filteredUsers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderAndCell.cellId, for: indexPath) as! UserSearchCell
        
        let user = self.filteredUsers[indexPath.item]
        
        cell.user = user
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 66)
    }
}

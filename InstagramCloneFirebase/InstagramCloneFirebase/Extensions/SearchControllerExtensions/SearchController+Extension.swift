//
//  SearchController+Extension.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 02.08.23.
//

import UIKit

extension UserSearchController {
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

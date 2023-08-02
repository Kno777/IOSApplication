//
//  HomeController+Extension.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 02.08.23.
//

import UIKit

extension HomeController {
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
        
        if posts.count > 0 {
            cell.post = posts[indexPath.item]
        }

        return cell
    }
}

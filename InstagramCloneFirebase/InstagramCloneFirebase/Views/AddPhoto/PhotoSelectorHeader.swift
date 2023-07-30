//
//  PhotoSelectorHeader.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 30.07.23.
//

import UIKit

class PhotoSelectorHeader: UICollectionViewCell {
    
    lazy var headerPhotoImage: UIImageView = {
       let image = UIImageView()
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(headerPhotoImage)
        
        headerPhotoImage.anchor(top: safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

//
//  UserSearchCell.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 01.08.23.
//

import UIKit

class UserSearchCell: UICollectionViewCell {
    
    var user: UserModel? {
        didSet {
            guard let user = user else { return }
            
            userProfileImageView.loadImage(urlString: user.profileImageUrl)
            
            usernameLabel.text = user.username
            
        }
    }
    
   private lazy var userProfileImageView: CustomImageView = {
       let image = CustomImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 50 / 2
        return image
    }()
    
    private lazy var usernameLabel: UILabel = {
       let label = UILabel()
        label.text = "Username"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(userProfileImageView)
        
        addSubview(usernameLabel)
        
        userProfileImageView.anchor(top: nil, left: leadingAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        userProfileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        usernameLabel.anchor(top: topAnchor, left: userProfileImageView.trailingAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(separatorView)
        
        separatorView.anchor(top: nil, left: usernameLabel.leadingAnchor, bottom: bottomAnchor, right: trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

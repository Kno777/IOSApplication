//
//  HomePostCell.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 31.07.23.
//

import UIKit

class HomePostCell: UICollectionViewCell {
    
    var post: UserPostModel? {
        didSet {
            guard let post = post else { return }
                        
            photoImageView.loadImage(urlString: post.imageUrl)
            
            usernameLabel.text = post.user.username
                        
            userProfileImageView.loadImage(urlString: post.user.profileImageUrl)
            
            //captionLabel.text = post?.caption
            setupAttributedCaption()
        }
    }
    
    private lazy var userProfileImageView: CustomImageView = {
        let image = CustomImageView()
         image.translatesAutoresizingMaskIntoConstraints = false
         image.contentMode = .scaleAspectFill
         image.clipsToBounds = true
         image.backgroundColor = .blue
         image.layer.cornerRadius = 40 / 2
         return image
    }()
    
    lazy var photoImageView: CustomImageView = {
       let image = CustomImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
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
    
    private lazy var optionsButton: UIButton = {
       let buttom = UIButton()
        buttom.setTitle("...", for: .normal)
        buttom.setTitleColor(.black, for: .normal)
        buttom.translatesAutoresizingMaskIntoConstraints = false
        return buttom
    }()
    
    private lazy var likeButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "like_unselected")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var commentButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "comment")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var sendButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "send")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var bookmarkButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "ribbon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var captionLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(photoImageView)
        addSubview(userProfileImageView)
        addSubview(usernameLabel)
        addSubview(optionsButton)
        
        photoImageView.anchor(top: userProfileImageView.bottomAnchor, left: leadingAnchor, bottom: nil, right: trailingAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        photoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        userProfileImageView.anchor(top: topAnchor, left: leadingAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        
        usernameLabel.anchor(top: userProfileImageView.topAnchor, left: userProfileImageView.trailingAnchor, bottom: userProfileImageView.bottomAnchor, right: optionsButton.leadingAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        optionsButton.anchor(top: topAnchor, left: nil, bottom: photoImageView.topAnchor, right: safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 44, height: 0)
        
        setupActionButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupAttributedCaption() {
        
        guard let post = self.post else { return }
        
        let attributedText = NSMutableAttributedString(string: post.user.username, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.black])
        
        attributedText.append(NSAttributedString(string: " \(post.caption)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.black]))
        
        attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 4)]))
        
        
        let timeAgoDisplay = post.creationDate.timeAgoDisplay()
        
        attributedText.append(NSAttributedString(string: timeAgoDisplay, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        captionLabel.attributedText = attributedText
    }
    
    fileprivate func setupActionButtons() {
        
        let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, sendButton])
        
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
     
        stackView.distribution = .fillEqually
        
        stackView.anchor(top: photoImageView.bottomAnchor, left: leadingAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 120, height: 50)
        
        addSubview(bookmarkButton)
        
        bookmarkButton.anchor(top: photoImageView.bottomAnchor, left: nil, bottom: nil, right: trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: -4, width: 40, height: 50)
        
        addSubview(captionLabel)
        
        captionLabel.anchor(top: stackView.bottomAnchor, left: leadingAnchor, bottom: bottomAnchor, right: trailingAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: -8, width: 0, height: 0)
    }
}

//
//  CommentCell.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 03.08.23.
//

import UIKit

class CommentCell: UICollectionViewCell {
    
    var comment: CommentModel? {
        didSet {
            
            guard let comment = comment else { return }
            
            let attributedText = NSMutableAttributedString(string: comment.user.username, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
            
            attributedText.append(NSAttributedString(string: " \(comment.text)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
            
            textView.attributedText = attributedText
            
            profileImageView.loadImage(urlString: comment.user.profileImageUrl)
        }
    }
    
    private lazy var textView: UITextView = {
       let textView = UITextView()
        textView.font = .systemFont(ofSize: 14)
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var profileImageView: CustomImageView = {
       let image = CustomImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 40 / 2
        image.backgroundColor = .red
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        addSubview(textView)
        
        addSubview(profileImageView)
        
        textView.anchor(top: topAnchor, left: profileImageView.trailingAnchor, bottom: bottomAnchor, right: trailingAnchor, paddingTop: 4, paddingLeft: 4, paddingBottom: -4, paddingRight: -4, width: 0, height: 0)
        
        profileImageView.anchor(top: topAnchor, left: leadingAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

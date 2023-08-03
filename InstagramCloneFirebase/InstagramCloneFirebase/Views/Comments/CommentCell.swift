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
            
            textLabel.text = comment.text
        }
    }
    
    private lazy var textLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.backgroundColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .green
        
        addSubview(textLabel)
        
        textLabel.anchor(top: topAnchor, left: leadingAnchor, bottom: bottomAnchor, right: trailingAnchor, paddingTop: 4, paddingLeft: 4, paddingBottom: -4, paddingRight: -4, width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

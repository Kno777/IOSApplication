//
//  PageCell.swift
//  SimpleApp
//
//  Created by Kno Harutyunyan on 14.07.23.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
            guard let unwrappedPage = page else { return }
            
            bearImageView.image = UIImage(named: unwrappedPage.imageName)
            
            let attributedText = NSMutableAttributedString(string: unwrappedPage.headerText, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])

            attributedText.append(NSAttributedString(string: "\n\n\n\(unwrappedPage.bodyText)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray]))
            
            descriptionTextView.attributedText = attributedText
            descriptionTextView.textAlignment = .center
        }
    }
    
    private let bearImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bear_first"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        let attributedText = NSMutableAttributedString(string: "Join us today in out fun and games", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])

        attributedText.append(NSAttributedString(string: "\n\n\nAre you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon.", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        let topImageContainer = UIView()
        addSubview(topImageContainer)
        topImageContainer.translatesAutoresizingMaskIntoConstraints = false
        topImageContainer.addSubview(bearImageView)
        addSubview(descriptionTextView)
        
        NSLayoutConstraint.activate([
            topImageContainer.topAnchor.constraint(equalTo: topAnchor),
            topImageContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            topImageContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            topImageContainer.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            
            bearImageView.centerXAnchor.constraint(equalTo: topImageContainer.centerXAnchor),
            bearImageView.centerYAnchor.constraint(equalTo: topImageContainer.centerYAnchor),
            
            bearImageView.heightAnchor.constraint(equalTo: topImageContainer.heightAnchor, multiplier: 0.5),

            
            descriptionTextView.topAnchor.constraint(equalTo: topImageContainer.bottomAnchor),
            descriptionTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
            descriptionTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40),
            descriptionTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}

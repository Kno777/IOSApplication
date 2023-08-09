//
//  SearchResultCell.swift
//  AppStoreJSONApi
//
//  Created by Kno Harutyunyan on 08.08.23.
//

import UIKit

final class SearchResultCell: UICollectionViewCell {
    
    private lazy var appIconImageView: UIImageView = {
       let image = UIImageView()
        image.backgroundColor = .red
        image.widthAnchor.constraint(equalToConstant: 64).isActive = true
        image.heightAnchor.constraint(equalToConstant: 64).isActive = true
        image.layer.cornerRadius = 12
        return image
    }()
    
    private lazy var appLabel: UILabel = {
       let label = UILabel()
        label.text = "APP NAME"
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
       let label = UILabel()
        label.text = "Photos & Videos"
        return label
    }()
    
    private lazy var ratingsLabel: UILabel = {
       let label = UILabel()
        label.text = "9.26M"
        return label
    }()
    
    private lazy var getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.layer.cornerRadius = 16
        return button
    }()
    
    private lazy var screenshot1ImageView = self.createImageView()
    private lazy var screenshot2ImageView = self.createImageView()
    private lazy var screenshot3ImageView = self.createImageView()

    private func createImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        return imageView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        let labelStackView = VerticalStackView(arrangedSubviews: [appLabel, categoryLabel, ratingsLabel])
                
        let infoTopStackView = UIStackView(arrangedSubviews: [appIconImageView, labelStackView, getButton])
                
        infoTopStackView.spacing = 12
        infoTopStackView.alignment = .center
        
        let appImagesStackView = UIStackView(arrangedSubviews: [screenshot1ImageView, screenshot2ImageView, screenshot3ImageView])
        
        appImagesStackView.spacing = 12
        appImagesStackView.distribution = .fillEqually
                
        let overallStackView = VerticalStackView(arrangedSubviews: [infoTopStackView, appImagesStackView], spacing: 16)
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(overallStackView)
        
        overallStackView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

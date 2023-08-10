//
//  AppRowCell.swift
//  AppStoreJSONApi
//
//  Created by Kno Harutyunyan on 09.08.23.
//

import UIKit

final class AppRowCell: UICollectionViewCell {
    
    lazy var imageView = UIImageView(corenerRadius: 12)
    
    lazy var nameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 20), color: nil, backgroundColor: nil)

    lazy var companyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 13), color: nil, backgroundColor: nil)
    
    private lazy var getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.layer.cornerRadius = 32 / 2
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        imageView.backgroundColor = .red
        imageView.constrainWidth(constant: 64)
        imageView.constrainHeight(constant: 64)
        
        let stackView = UIStackView(arrangedSubviews: [imageView, VerticalStackView(arrangedSubviews: [nameLabel, companyLabel], spacing: 4), getButton])
        
        addSubview(stackView)
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

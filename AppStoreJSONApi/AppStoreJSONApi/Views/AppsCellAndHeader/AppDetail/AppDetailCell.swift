//
//  AppDetailCell.swift
//  AppStoreJSONApi
//
//  Created by Kno Harutyunyan on 10.08.23.
//

import UIKit

final class AppDetailCell: UICollectionViewCell {
    
    lazy var appIconImageView = UIImageView(corenerRadius: 12)
    
    lazy var appNameLabel = UILabel(text: "FaceBook", font: .boldSystemFont(ofSize: 24), numberOfLines: 2, color: nil, backgroundColor: nil)
    
    lazy var whatsNewLabel = UILabel(text: "What's New", font: .boldSystemFont(ofSize: 20), numberOfLines: 1, color: nil, backgroundColor: nil)
    
    lazy var releaseLabel = UILabel(text: "Release", font: .boldSystemFont(ofSize: 16), numberOfLines: 0, color: nil, backgroundColor: nil)
    
    lazy var priceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("$4.99", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = .systemBlue
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.layer.cornerRadius = 32 / 2
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        appIconImageView.backgroundColor = .red
        appIconImageView.constrainWidth(constant: 140)
        appIconImageView.constrainHeight(constant: 140)
        
        let stackView = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [
                appIconImageView,
                VerticalStackView(arrangedSubviews: [
                    appNameLabel,
                    UIStackView(arrangedSubviews: [
                        priceButton, UIView()]), UIView()
                ], spacing: 12)
            ], customSpacing: 12),
            whatsNewLabel, releaseLabel
        ], spacing: 16)
        
        
        addSubview(stackView)
        
        stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("AppDetailCell")
    }
}


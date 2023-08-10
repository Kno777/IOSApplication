//
//  AppsHeaderCell.swift
//  AppStoreJSONApi
//
//  Created by Kno Harutyunyan on 09.08.23.
//

import UIKit

final class AppsHeaderCell: UICollectionViewCell {
    
    lazy var companyLabel = UILabel(text: "Facebook", font: .boldSystemFont(ofSize: 12), color: .systemBlue, backgroundColor: nil)
    
    lazy var titleLabel = UILabel(text: "Keeping up with friends is faster than ever", font: .systemFont(ofSize: 24), color: nil, backgroundColor: nil)
    
    lazy var imageView = UIImageView(corenerRadius: 12)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.numberOfLines = 2
        
        imageView.backgroundColor = .white
        let stackView = VerticalStackView(arrangedSubviews: [companyLabel, titleLabel, imageView], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("AppsHeaderCell")
    }
}

//
//  AppsGroupCell.swift
//  AppStoreJSONApi
//
//  Created by Kno Harutyunyan on 09.08.23.
//

import UIKit

final class AppsGroupCell: UICollectionViewCell {
    
    let horizontalViewController = AppsHorizontalController()
    
    let appSectionLabel = UILabel(text: "App Section", font: .boldSystemFont(ofSize: 30), color: nil, backgroundColor: nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(appSectionLabel)
        addSubview(horizontalViewController.view)
        
        horizontalViewController.view.anchor(top: appSectionLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        appSectionLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    } 
}

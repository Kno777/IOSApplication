//
//  AppsGroupCell.swift
//  AppStoreJSONApi
//
//  Created by Kno Harutyunyan on 09.08.23.
//

import UIKit

final class AppsGroupCell: UICollectionViewCell {
    
    //lazy var appSectionLabel: UILabel = {
    //   let label = UILabel()
    //    label.text = "App Section"
    //    label.font = .boldSystemFont(ofSize: 30)
    //    label.backgroundColor = .red
    //    return label
    //}()
    
    let horizontalViewController = AppsHorizontalController(collectionViewLayout: UICollectionViewFlowLayout())
    
    let appSectionLabel = UILabel(text: "App Section", font: .boldSystemFont(ofSize: 30), color: nil, backgroundColor: nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        
        addSubview(appSectionLabel)
        addSubview(horizontalViewController.view)
        
        horizontalViewController.view.anchor(top: appSectionLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        horizontalViewController.view.backgroundColor = .blue
        
        appSectionLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

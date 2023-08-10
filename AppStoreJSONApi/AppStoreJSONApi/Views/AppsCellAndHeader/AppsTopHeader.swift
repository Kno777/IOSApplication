//
//  AppsTopHeader.swift
//  AppStoreJSONApi
//
//  Created by Kno Harutyunyan on 09.08.23.
//

import UIKit

final class AppsTopHeader: UICollectionReusableView {
    
    lazy var appHeaderHorizontalController = AppsHeaderHorizontalController(collectionViewLayout: UICollectionViewFlowLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(appHeaderHorizontalController.view)
        appHeaderHorizontalController.view.fillSuperview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("AppsTopHeader")
    }
}

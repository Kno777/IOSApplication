//
//  UIImageView+init.swift
//  AppStoreJSONApi
//
//  Created by Kno Harutyunyan on 09.08.23.
//

import UIKit

extension UIImageView {
    convenience init(corenerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = corenerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}

//
//  UIStackView+Spacing.swift
//  AppStoreJSONApi
//
//  Created by Kno Harutyunyan on 10.08.23.
//

import UIKit

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], customSpacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = customSpacing
    }
}

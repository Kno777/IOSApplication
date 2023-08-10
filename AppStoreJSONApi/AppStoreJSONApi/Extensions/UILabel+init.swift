//
//  UILabel+init.swift
//  AppStoreJSONApi
//
//  Created by Kno Harutyunyan on 09.08.23.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont, numberOfLines: Int = 1, color: UIColor?, backgroundColor: UIColor?) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.textColor = color == nil ? self.textColor : color
        self.backgroundColor = backgroundColor == nil ? self.backgroundColor : backgroundColor
        self.numberOfLines = numberOfLines
    }
}

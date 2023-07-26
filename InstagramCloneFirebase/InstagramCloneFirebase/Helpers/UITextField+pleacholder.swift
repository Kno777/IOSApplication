//
//  UITextField+attributedStringStyle.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 26.07.23.
//

import UIKit

func placeholderTextandColor(title: String, color: UIColor, fontSize: CGFloat) -> NSAttributedString {
    let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: color,
                .font: UIFont.systemFont(ofSize: fontSize)
        ]
    let attributedPlaceholder = NSAttributedString(string: title, attributes: attributes)
    return attributedPlaceholder
}

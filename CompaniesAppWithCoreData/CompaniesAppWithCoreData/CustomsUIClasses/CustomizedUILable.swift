//
//  CustomizedUILable.swift
//  CompaniesAppWithCoreData
//
//  Created by Kno Harutyunyan on 22.07.23.
//

import UIKit

// let's create a UILable subclass for custom text drawing

class IntendedLableForSection: UILabel {
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        let customRect = rect.inset(by: insets)
        super.drawText(in: customRect)
    }
}

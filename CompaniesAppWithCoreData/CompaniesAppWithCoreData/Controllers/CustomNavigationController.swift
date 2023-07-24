//
//  CustomNavigationController.swift
//  CompaniesAppWithCoreData
//
//  Created by Kno Harutyunyan on 18.07.23.
//

import UIKit

// this navigation controller for to change (date time, bettery, and etc) to light mode
class CustomNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

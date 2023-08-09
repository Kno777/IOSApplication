//
//  MainTabBarController.swift
//  AppStoreJSONApi
//
//  Created by Kno Harutyunyan on 08.08.23.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createNavigationController(title: "Apps", imageName: "apps", rootViewController: AppsMainController(collectionViewLayout: UICollectionViewFlowLayout())),
            createNavigationController(title: "Search", imageName: "search", rootViewController: AppsSearchController(collectionViewLayout: UICollectionViewFlowLayout())),
            createNavigationController(title: "Today", imageName: "today_icon", rootViewController: UIViewController()),
        ]
    }
    
    fileprivate func createNavigationController(title: String, imageName: String, rootViewController: UIViewController) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        rootViewController.view.backgroundColor = .white
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        return navController
    }
}

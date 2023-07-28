//
//  MainTabBarController.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 27.07.23.
//

import UIKit


class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        let navController = UINavigationController(rootViewController: userProfileController)
        
        navController.tabBarItem.image = UIImage(named: "profile_unselected")?.withRenderingMode(.alwaysOriginal)
        navController.tabBarItem.selectedImage = UIImage(named: "profile_selected")?.withRenderingMode(.alwaysOriginal)
      
        viewControllers = [
            navController,
            UIViewController()
        ]
    }
}








//
//fileprivate func createNavController(for rootViewController: UIViewController,
//                                                  title: String,
//                                                  image: UIImage) -> UIViewController {
//
//        let navController = UINavigationController(rootViewController: rootViewController)
//        navController.tabBarItem.title = title
//        navController.tabBarItem.image = image
//        navController.navigationBar.prefersLargeTitles = true
//        rootViewController.navigationItem.title = title
//        return navController
//    }
//
//func setupVCs() {
//        viewControllers = [
//            createNavController(for: ViewController(), title: NSLocalizedString("Search", comment: ""), image: UIImage(systemName: "magnifyingglass")!),
//            createNavController(for: ViewController(), title: NSLocalizedString("Home", comment: ""), image: UIImage(systemName: "house")!),
//            createNavController(for: UserProfileController(), title: NSLocalizedString("UserProfile", comment: ""), image: UIImage(systemName: "person")!)
//        ]
//    }

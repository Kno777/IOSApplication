//
//  MainTabBarController.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 27.07.23.
//

import UIKit
import Firebase


class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let index = viewControllers?.firstIndex(of: viewController)
        print(index ?? "")
        
        if index == 2 {
            let layout = UICollectionViewFlowLayout()
            let photoSelectorController = PhotoSelectorController(collectionViewLayout: layout)
            let navigationController = UINavigationController(rootViewController: photoSelectorController)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true)
        }
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        view.backgroundColor = .systemBackground
        
        if Auth.auth().currentUser == nil {
            // show if user is not logged in
            
            DispatchQueue.main.async {
                let loginController = LoginController()
                let navigationController = UINavigationController(rootViewController: loginController)
                navigationController.modalPresentationStyle = .fullScreen
                self.present(navigationController, animated: true)
            }
            return
        }
        
        setupViewControllers()
        
    }
    
    func setupViewControllers() {
        
        // home
        let homeNavigationController = templetNavigationController(unselectedImage: UIImage(named: "home_unselected")!, selectedImage: UIImage(named: "home_selected")!, rootViewController: HomeController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        // search
        let searchNavigationController = templetNavigationController(unselectedImage: UIImage(named: "search_unselected")!, selectedImage: UIImage(named: "search_selected")!)
        
        // plus
        let plusNavigationController = templetNavigationController(unselectedImage: UIImage(named: "plus_unselected")!, selectedImage: UIImage(named: "plus_unselected")!)
        
        // like
        let likeNavigationController = templetNavigationController(unselectedImage: UIImage(named: "like_unselected")!, selectedImage: UIImage(named: "like_selected")!)
        
        // user profile
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        let userProfileNavigationController = UINavigationController(rootViewController: userProfileController)
        
        userProfileNavigationController.tabBarItem.image = UIImage(named: "profile_unselected")
        userProfileNavigationController.tabBarItem.selectedImage = UIImage(named: "profile_selected")
        
        tabBar.tintColor = .black
        tabBar.backgroundColor = .systemGray6
      
        viewControllers = [
            homeNavigationController,
            searchNavigationController,
            plusNavigationController,
            likeNavigationController,
            userProfileNavigationController,
        ]
        
        // modify tab bar items insets
        
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    fileprivate func templetNavigationController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.image = unselectedImage
        navigationController.tabBarItem.selectedImage = selectedImage
        return navigationController
    }
}

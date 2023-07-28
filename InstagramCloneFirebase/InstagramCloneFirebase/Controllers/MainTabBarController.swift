//
//  MainTabBarController.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 27.07.23.
//

import UIKit
import Firebase


class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        let navController = UINavigationController(rootViewController: userProfileController)
        
        navController.tabBarItem.image = UIImage(named: "profile_unselected")?.withRenderingMode(.alwaysOriginal)
        navController.tabBarItem.selectedImage = UIImage(named: "profile_selected")?.withRenderingMode(.alwaysOriginal)
      
        viewControllers = [
            navController,
            SignUpController(),
        ]
    }
}

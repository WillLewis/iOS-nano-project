//
//  MainTabBarController.swift
//  FriendlyChatSwift
//
//  Created by William Lewis on 4/8/20.
//  Copyright © 2020 Google Inc. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseUI
import FirebaseMessaging

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        if Auth.auth().currentUser == nil {
            //show if not logged in
            DispatchQueue.main.async {
                let splashController = SplashViewController()
                let navController = UINavigationController(rootViewController: splashController)
                self.present(navController, animated: true, completion: nil)
            }
            
            return
        }
        
        setupViewControllers()
    }
    
    func setupViewControllers() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let upcomingViewController = storyboard.instantiateViewController(withIdentifier: "UpcomingViewController") as! UpcomingViewController
        let upcomingNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "home"), selectedImage: #imageLiteral(resourceName: "home-selected"), rootViewController: upcomingViewController)
        
        let profileNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "user"), selectedImage: #imageLiteral(resourceName: "user-selected"), rootViewController: ProfileController())
        
        tabBar.tintColor = .black
        tabBar.backgroundColor = .blue
        
        viewControllers = [upcomingNavController, profileNavController]
        
        //modify tab bar item insets
        guard let items = tabBar.items else { return }
            
        for item in items {
                item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.backgroundColor = UIColor.white
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
}

//
//  SceneDelegate.swift
//  OnParSwift
//
//  Created by William Lewis on 5/15/20.
//  Copyright © 2020 Google Inc. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    //@available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            //let navController = BaseTabBarController()
            window.rootViewController = MainTabBarController()
            
            self.window = window
            window.makeKeyAndVisible()
        }
        
    }
    
}

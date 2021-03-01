//
//  SceneDelegate.swift
//  dough-bros-ios
//
//  Created by Alan Yan on 2020-10-09.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let loginNav = UINavigationController(rootViewController: WelcomeViewController())
            loginNav.isNavigationBarHidden = true
            
//            let carlos = CarlosViewController()
//            window.rootViewController = carlos
            
             window.rootViewController = loginNav
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


    
    private func setupTabBarController() -> UITabBarController {
        let tabController = UITabBarController()
        
        let sampleVC = SampleViewController()
        sampleVC.tabBarItem = UITabBarItem(title: "SAMPLE", image: UIImage(systemName: ""), tag: 0)
        
        let tutorialsVC = TutorialViewController()
        tutorialsVC.tabBarItem = UITabBarItem(title: "Tutorial", image: UIImage(systemName: "book.fill"), tag: 1)
        
        let loginVC = LoginViewController()
        loginVC.tabBarItem = UITabBarItem(title: "Login", image: UIImage(systemName: "person.fill"), tag: 2)
    
        let groupsVC = GroupsViewController()
        let homeNav = UINavigationController(rootViewController: groupsVC)
        homeNav.navigationBar.isHidden = true
        groupsVC.tabBarItem = UITabBarItem(title: "Groups", image: UIImage(systemName: "person.3.fill"), tag: 3)
        
        tabController.viewControllers = [sampleVC, tutorialsVC, loginVC, homeNav]
        
        return tabController
    }
}


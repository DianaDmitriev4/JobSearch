//
//  AppDelegate.swift
//  JobSearch
//
//  Created by User on 12.03.2024.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var coordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        
//        let navController = UINavigationController()
//        coordinator = AppCoordinator(navigationController: navController)
//        coordinator?.start()
//        
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window {
//            window.rootViewController = ContainerViewController() ВЕРНУТЬ НА МЕСТО!!!
            window.rootViewController = TabBarController()
            window.makeKeyAndVisible()
        }
        
        return true
    }
}


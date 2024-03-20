//
//  AppDelegate.swift
//  JobSearch
//
//  Created by User on 12.03.2024.
//

import CoreData
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { description, error in
            if let error {
                fatalError("Unable to load persistence stores: \(error)")
            }
        }
        return container
    }()
    
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
//            window.rootViewController = ContainerViewController()
                        window.rootViewController = TabBarController()
            window.makeKeyAndVisible()
        }
        
        return true
    }
}


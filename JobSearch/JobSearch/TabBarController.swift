//
//  TabBarController.swift
//  JobSearch
//
//  Created by User on 13.03.2024.
//

import UIKit

final class TabBarController: UITabBarController {
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }
    
    // MARK: - Private methods
    private func makeUI() {
        setupVC()
        tabBar.unselectedItemTintColor = .lightGray
        makeSeparatorLayer()
    }
    
    private func setupVC() {
        viewControllers = [
            setupNavigationControllers(rootVC: SearchViewController(viewModel: SearchViewModel()), image: UIImage(named: "search"), title: "Поиск"),
            setupNavigationControllers(rootVC: SelectedViewController(), image: UIImage(named: "selected"), title: "Избранное"),
            setupNavigationControllers(rootVC: ResponsesViewController(), image: UIImage(named: "responses"), title: "Отклики"),
            setupNavigationControllers(rootVC: MessagesViewController(), image: UIImage(named: "messages"), title: "Сообщения"),
            setupNavigationControllers(rootVC: ProfileViewController(), image: UIImage(named: "profile"), title: "Профиль")
        ]
    }
    
    private func setupNavigationControllers(rootVC: UIViewController, image: UIImage?, title: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootVC)
        navController.tabBarItem.image = image?.withRenderingMode(.alwaysOriginal)
        navController.tabBarItem.selectedImage = image?.withTintColor(.systemBlue)
        navController.tabBarItem.title = title
        navController.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.systemBlue], for: .selected)
        
        return navController
    }
    
    private func makeSeparatorLayer() {
        let separatorLayer = CALayer()
        separatorLayer.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5).cgColor
        separatorLayer.frame = CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 1)
        tabBar.layer.addSublayer(separatorLayer)
    }
}

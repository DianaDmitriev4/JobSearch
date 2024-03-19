//
//  ContainerViewController.swift
//  JobSearch
//
//  Created by User on 13.03.2024.
//

import SnapKit
import UIKit

class ContainerViewController: UIViewController {
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        makeConstraints()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        makeControllers()
    }
    
    private func makeControllers() {
        let tabBarController = TabBarController()
        addChild(tabBarController)
        view.addSubview(tabBarController.view)
        tabBarController.didMove(toParent: self)
        
        let loginVC = LoginViewController(viewModel: LoginViewModel()) 
        let navigationController = UINavigationController(rootViewController: loginVC)
        addChild(navigationController)
        view.addSubview(navigationController.view)
        navigationController.didMove(toParent: self)
    }
    
    private func makeConstraints() {
        guard let tabBarController = children.first as? TabBarController,
              let loginVC = children.last as? UINavigationController else { return }
        
        tabBarController.view.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(tabBarController.tabBar.frame.height)
        }
        
        loginVC.view.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(tabBarController.view.snp.top)
            make.top.equalToSuperview()
        }
    }
}

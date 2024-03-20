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
//        let navigationController = UINavigationController(rootViewController: loginVC)
        addChild(loginVC)
        view.addSubview(loginVC.view)
        loginVC.didMove(toParent: self)
    }
    
    private func makeConstraints() {
        guard let tabBarController = children.first as? TabBarController,
              let loginVC = children.last else { return }
        
        tabBarController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loginVC.view.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(tabBarController.tabBar.snp.top)
        }
    }
}

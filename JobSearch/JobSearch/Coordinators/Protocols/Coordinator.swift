//
//  Coordinator.swift
//  JobSearch
//
//  Created by User on 12.03.2024.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
}

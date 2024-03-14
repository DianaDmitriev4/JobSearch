//
//  UIView + Extens.swift
//  JobSearch
//
//  Created by User on 14.03.2024.
//

import UIKit

extension UIView {
    func addSubviews(views: [UIView]) {
        views.forEach { view in
            addSubview(view)
        }
    }
}

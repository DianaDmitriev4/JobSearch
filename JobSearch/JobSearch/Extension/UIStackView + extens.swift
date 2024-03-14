//
//  UIStackView + extens.swift
//  JobSearch
//
//  Created by User on 14.03.2024.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(views: [UIView]) {
        views.forEach { view in
            addArrangedSubview(view)
        }
    }
}

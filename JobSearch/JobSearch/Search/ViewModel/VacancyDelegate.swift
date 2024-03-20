//
//  VacancyDelegate.swift
//  JobSearch
//
//  Created by User on 20.03.2024.
//

import Foundation

protocol VacancyDelegate: AnyObject {
    func buttonTapped(_ cell: VacanciesCell)
}

//
//  SearchViewModel.swift
//  JobSearch
//
//  Created by User on 15.03.2024.
//

import UIKit

protocol SearchViewModelProtocol {
    var quickFilters: [QuickFiltersModel] { get }
    var vacancies: [VacanciesModel] { get }
}

final class SearchViewModel: SearchViewModelProtocol{
    var vacancies: [VacanciesModel] = []
    
    let quickFilters: [QuickFiltersModel] = [QuickFiltersModel(icon: UIImage(named: "firstIcon") ?? .clear,
                                                               iconColor: .darkBlue, 
                                                               description: "Вакансии рядом с вами",
                                                               textAction: nil),
                                             QuickFiltersModel(icon: UIImage(named: "secondIcon") ?? .clear,
                                                               iconColor: .darkGreen,
                                                               description: "Поднять резюме в поиске", 
                                                               textAction: nil),
                                             QuickFiltersModel(icon: UIImage(named: "thirdIcon") ?? .clear,
                                                               iconColor: .darkGreen,
                                                               description: "Временная работа и подработка", 
                                                               textAction: "Поднять")
    ]
}

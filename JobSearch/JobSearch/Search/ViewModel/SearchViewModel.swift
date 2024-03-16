//
//  SearchViewModel.swift
//  JobSearch
//
//  Created by User on 15.03.2024.
//

import UIKit

protocol SearchViewModelProtocol {
    var quickFilters: [QuickFiltersModel] { get }
    var vacancies: [VacanciesModel] { get set }
    var image: Dynamic<UIImage> { get set }
    
    func getVacancies()
}

final class SearchViewModel: SearchViewModelProtocol {
    var image = Dynamic(UIImage())
    var vacancies: [VacanciesModel] = [] {
        didSet {
            print(vacancies.count)
        }
    }
    
    let quickFilters: [QuickFiltersModel] = [QuickFiltersModel(icon: UIImage(named: "firstIcon") ?? .clear,
                                                               iconColor: .darkBlue,
                                                               description: "Вакансии рядом с вами",
                                                               textAction: nil),
                                             QuickFiltersModel(icon: UIImage(named: "secondIcon") ?? .clear,
                                                               iconColor: .darkGreen,
                                                               description: "Поднять резюме в поиске",
                                                               textAction: "Поднять"),
                                             QuickFiltersModel(icon: UIImage(named: "thirdIcon") ?? .clear,
                                                               iconColor: .darkGreen,
                                                               description: "Временная работа и подработка",
                                                               textAction: nil)]
    
    func getVacancies() {
        ApiManager.getVacancies { [weak self] result in
            self?.handleResult(result: result)
        }
    }
    
    private func handleResult(result: Result<[VacanciesModel], Error>) {
        DispatchQueue.main.async { [weak self] in
            switch result {
            case .success(let success):
                self?.vacancies = success
            case .failure(let failure):
                print(failure.localizedDescription) // MAYBE MAKE ALERT WITH SHOW DESCRIPTION
            }
        }
    }
}

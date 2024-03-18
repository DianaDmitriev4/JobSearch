//
//  SearchViewModel.swift
//  JobSearch
//
//  Created by User on 15.03.2024.
//

import UIKit

protocol SearchViewModelProtocol {
    var quickFilters: [QuickFiltersModel] { get }
    var vacancies: [Vacancy] { get set }
    var numberOfVacancies: ((Int) -> Void)? { get set }
    var reloadCollectionView: (() -> Void)? { get set }
    var selectedImage: Dynamic<UIImage> { get set }
    
    func getVacancies()
}

extension SearchViewModelProtocol {
     var favorites: [Vacancy] {
        return []
    }
}

final class SearchViewModel: SearchViewModelProtocol {
    var selectedImage = Dynamic(UIImage())
    var reloadCollectionView: (() -> Void)?
    var numberOfVacancies: ((Int) -> Void)?
    var vacancies: [Vacancy] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                if let self {
                    self.numberOfVacancies?(self.vacancies.count)
                    self.reloadCollectionView?()
                }
            }
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
    
    func isSelected(_ vacancy: Vacancy) -> Bool {
        favorites.contains(where: { $0.title == vacancy.title } )
        }
    
    private func handleResult(result: Result<[Vacancy], Error>) {
        DispatchQueue.main.async { [weak self] in
            switch result {
            case .success(let success):
                self?.vacancies = success
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}

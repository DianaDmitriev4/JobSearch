//
//  SelectedViewModel.swift
//  JobSearch
//
//  Created by User on 18.03.2024.
//

import Foundation

protocol SelectedViewModelProtocol {
    var selectedVacancy: [Vacancy] { get set }
    var reloadCollection: (() -> Void)? { get set }
    var vacancyClosure: (() -> Void)? { get set }
    
    func getVacancy()
    func buttonTapped(vacancy: Vacancy, isSelected: Bool)
    func isSelected(_ vacancy: Vacancy) -> Bool
}

final class SelectedViewModel: SelectedViewModelProtocol {
    var reloadCollection: (() -> Void)?
    var vacancyClosure: (() -> Void)?
    
    var selectedVacancy: [Vacancy] = [] {
        didSet {
            reloadCollection?()
        }
    }
    
    func buttonTapped(vacancy: Vacancy, isSelected: Bool) {
        if isSelected {
            selectedVacancy.removeAll(where: { $0.title == vacancy.title })
            remove(vacancy)
        } else {
            selectedVacancy.append(vacancy)
            save(vacancy)
        }
    }
    
    func isSelected(_ vacancy: Vacancy) -> Bool {
        selectedVacancy.contains(where: { $0.title == vacancy.title} )
   }
    
    func getVacancy() {
        selectedVacancy = VacancyPersistent.fetchAll()
    }
    
    private func save(_ vacancy: Vacancy) {
        VacancyPersistent.save(vacancy)
    }
    
    private func remove(_ vacancy: Vacancy) {
        VacancyPersistent.deleteEntity(vacancy)
    }
}

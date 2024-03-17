//
//  VacancyViewModel.swift
//  JobSearch
//
//  Created by User on 17.03.2024.
//

import Foundation

final class VacancyViewModel {
    let lookingNumber: Int?
    let title: String?
    let address: AddressViewModel
    let company: String?
    let experience: ExperienceViewModel?
    let publishedDate: String?
    let isFavorite: Bool?
    let salary: SalaryViewModel?
    let schedules: [String]
    let appliedNumber: Int?
    let vacancyDescription: String?
    let responsibilities: String?
    let questions: [String]?
    
    init(_ dataSource: Vacancy) {
        self.lookingNumber = dataSource.lookingNumber
        self.title = dataSource.title
        self.address = AddressViewModel(town: dataSource.address.town, street: dataSource.address.street, house: dataSource.address.house)
        self.company = dataSource.company
        self.experience = ExperienceViewModel(previewText: dataSource.experience?.previewText, text: dataSource.experience?.text)
        self.publishedDate = dataSource.publishedDate
        self.isFavorite = dataSource.isFavorite
        self.salary = SalaryViewModel(full: dataSource.salary?.full, short: dataSource.salary?.short)
        self.schedules = dataSource.schedules.compactMap { $0 }
        self.appliedNumber = dataSource.appliedNumber
        self.vacancyDescription = dataSource.vacancyDescription
        self.responsibilities = dataSource.responsibilities
        self.questions = dataSource.questions?.compactMap { $0 }
    }
}

// MARK: - Types
struct AddressViewModel {
    let town, street, house: String?
}

struct ExperienceViewModel {
    let previewText, text: String?
}

struct SalaryViewModel {
    let full, short: String?
}

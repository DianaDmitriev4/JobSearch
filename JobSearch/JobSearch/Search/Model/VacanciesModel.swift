//
//  VacanciesModel.swift
//  JobSearch
//
//  Created by User on 15.03.2024.
//

import Foundation

// MARK: - Welcome3
struct VacanciesModel {
    let offers: [Offer]
    let vacancies: [Vacancy]
}

// MARK: - Offer
struct Offer {
    let id: String?
    let title: String
    let link: String
    let button: Button?
}

// MARK: - Button
struct Button {
    let text: String
}

// MARK: - Vacancy
struct Vacancy {
    let id: String
    let lookingNumber: Int?
    let title: String
    let address: Address
    let company: String
    let experience: Experience
    let publishedDate: String
    let isFavorite: Bool
    let salary: Salary
    let schedules: [String]
    let appliedNumber: Int?
    let vacancyDescription: String?
    let responsibilities: String
    let questions: [String]
}

// MARK: - Address
struct Address {
    let town, street, house: String
}

// MARK: - Experience
struct Experience {
    let previewText, text: String
}

// MARK: - Salary
struct Salary {
    let full: String
    let short: String?
}

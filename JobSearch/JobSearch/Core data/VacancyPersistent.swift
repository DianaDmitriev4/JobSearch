//
//  VacancyPersistent.swift
//  JobSearch
//
//  Created by User on 18.03.2024.
//

import CoreData
import Foundation

final class VacancyPersistent {
    static let context = AppDelegate.persistentContainer.viewContext
    
    // MARK: - Methods
    static func save(_ vacancy: Vacancy) {
        var entity: VacancyEntity?
        if let ent = getEntity(vacancy) {
            entity = ent
        } else {
            guard let description = NSEntityDescription.entity(forEntityName: "VacancyEntity", in: context) else { return }
            entity = VacancyEntity(entity: description, insertInto: context)
        }
        
        entity?.address = vacancy.address.town
        entity?.company = vacancy.company
        entity?.experience = vacancy.experience?.previewText
        entity?.lookingNumber = Int32(vacancy.lookingNumber ?? 0)
        entity?.publishedDate = vacancy.publishedDate
        entity?.salary = vacancy.salary?.short
        entity?.schedules = vacancy.schedules.joined(separator: ", ")
        entity?.title = vacancy.title
        entity?.appliedNumber = Int32(vacancy.appliedNumber ?? 0)
        entity?.responsibilities = vacancy.responsibilities
        entity?.question = vacancy.questions?.joined(separator: ", ")
        
        saveContext()
    }
    
    static func deleteEntity(_ vacancy: Vacancy) {
        guard let entity = getEntity(vacancy) else { return }
        context.delete(entity)
        saveContext()
    }
    
    static func fetchAll() -> [Vacancy] {
        let request = VacancyEntity.fetchRequest()
        do {
            let vacancy = try context.fetch(request)
            return convert(entity: vacancy)
        } catch let error {
            debugPrint("Fetch vacancy error: \(error)")
            return []
        }
    }
    
    // MARK: - Private methods
    private static func getEntity(_ vacancy: Vacancy) -> VacancyEntity? {
        let request = VacancyEntity.fetchRequest()
        if let title = vacancy.title {
            let predicate = NSPredicate(format: "title = %@", title)
            request.predicate = predicate
        }
        
        do {
            let objects = try context.fetch(request)
            return objects.first
        } catch let error {
            debugPrint("Fetch error: \(error)")
            return nil
        }
    }
    
    private static func convert(entity: [VacancyEntity]) -> [Vacancy] {
        let vacancy = entity.map { Vacancy(lookingNumber: Int($0.lookingNumber),
                                           title: $0.title,
                                           address: Address(town: $0.address, street: nil, house: nil),
                                           company: $0.company,
                                           experience: Experience(previewText: $0.experience, text: nil),
                                           publishedDate: $0.publishedDate,
                                           salary: Salary(full: nil, short: $0.salary),
                                           schedules: $0.schedules?.components(separatedBy: ", ") ?? [],
                                           appliedNumber: Int($0.appliedNumber),
                                           description: $0.description,
                                           responsibilities: $0.responsibilities,
                                           questions: $0.question?.components(separatedBy: ", ")) }
        return vacancy
    }
    
    private static func saveContext() {
        do {
            try context.save()
        } catch let error {
            debugPrint("Save not error: \(error)")
        }
    }
}

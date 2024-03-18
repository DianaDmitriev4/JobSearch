//
//  VacancyEntity+CoreDataProperties.swift
//  JobSearch
//
//  Created by User on 18.03.2024.
//
//

import Foundation
import CoreData


extension VacancyEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VacancyEntity> {
        return NSFetchRequest<VacancyEntity>(entityName: "VacancyEntity")
    }

    @NSManaged public var lookingNumber: Int32
    @NSManaged public var appliedNumber: Int32
    @NSManaged public var responsibilities: String?
    @NSManaged public var question: String?
    @NSManaged public var title: String?
    @NSManaged public var address: String?
    @NSManaged public var company: String?
    @NSManaged public var experience: String?
    @NSManaged public var publishedDate: String?
    @NSManaged public var salary: String?
    @NSManaged public var schedules: String?

}

extension VacancyEntity : Identifiable {

}

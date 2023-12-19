//
//  Questions+CoreDataProperties.swift
//  five.minutes.math.drills
//
//  Created by Quantmis on 07/12/2023.
//
//

import Foundation
import CoreData


extension Questions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Questions> {
        return NSFetchRequest<Questions>(entityName: "Questions")
    }

    @NSManaged public var correct_answer: String?
    @NSManaged public var questions: String?
    @NSManaged public var user_answer: String?
    @NSManaged public var session: Sessions?

}

extension Questions : Identifiable {

}

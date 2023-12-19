//
//  Sessions+CoreDataProperties.swift
//  five.minutes.math.drills
//
//  Created by Quantmis on 07/12/2023.
//
//

import Foundation
import CoreData


extension Sessions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sessions> {
        return NSFetchRequest<Sessions>(entityName: "Sessions")
    }

    @NSManaged public var end_at: Int64
    @NSManaged public var score: Int16
    @NSManaged public var start_at: Int64
    @NSManaged public var status: Int16
    @NSManaged public var questions: NSSet?

}

// MARK: Generated accessors for questions
extension Sessions {

    @objc(addQuestionsObject:)
    @NSManaged public func addToQuestions(_ value: Questions)

    @objc(removeQuestionsObject:)
    @NSManaged public func removeFromQuestions(_ value: Questions)

    @objc(addQuestions:)
    @NSManaged public func addToQuestions(_ values: NSSet)

    @objc(removeQuestions:)
    @NSManaged public func removeFromQuestions(_ values: NSSet)

}



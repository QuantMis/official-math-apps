//
//  Stuffs+CoreDataProperties.swift
//  five.minutes.math.drills
//
//  Created by Quantmis on 21/12/2023.
//
//

import Foundation
import CoreData


extension Stuffs {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stuffs> {
        return NSFetchRequest<Stuffs>(entityName: "Stuffs")
    }

    @NSManaged public var name: String?
    @NSManaged public var image: String?
    @NSManaged public var price: Int16
    @NSManaged public var category: String?
    @NSManaged public var unlocked: Bool

}


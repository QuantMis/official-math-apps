//
//  Wallet+CoreDataProperties.swift
//  five.minutes.math.drills
//
//  Created by Quantmis on 21/12/2023.
//
//

import Foundation
import CoreData


extension Wallet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Wallet> {
        return NSFetchRequest<Wallet>(entityName: "Wallet")
    }

    @NSManaged public var coins: Int16

}



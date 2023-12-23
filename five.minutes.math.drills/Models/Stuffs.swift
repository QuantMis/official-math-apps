//
//  Stuffs.swift
//  five.minutes.math.drills
//
//  Created by Quantmis on 21/12/2023.
//

import SwiftUI
import Foundation
import CoreData

extension Stuffs : Identifiable {
    private static var stuffsFetchRequest: NSFetchRequest<Stuffs> {
        NSFetchRequest(entityName: "Stuffs")
    }
    
    static func all() -> NSFetchRequest<Stuffs> {
        let request: NSFetchRequest<Stuffs> = stuffsFetchRequest
        request.sortDescriptors = []
        return request
    }
    
    static func byCategory(category:String) -> NSFetchRequest<Stuffs> {
        let request: NSFetchRequest<Stuffs> = stuffsFetchRequest
        request.predicate = NSPredicate(format: "category == %@", category)
        request.sortDescriptors = []
        return request
    }
}

//
//  CoreDataProvider.swift
//  five.minutes.math.drills
//
//  Created by Quantmis on 05/12/2023.
//

import Foundation
import CoreData

final class CoreDataProvider {
    static let shared = CoreDataProvider()
    
    private let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    var newContext: NSManagedObjectContext {
        persistentContainer.newBackgroundContext()
    }
    
    private init() {
        // load datamodel
        persistentContainer = NSPersistentContainer(name: "5minmath")
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                fatalError("Unable to load store with error: \(error)")
            }
        }
    }
}

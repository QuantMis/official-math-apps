//
//  Wallet.swift
//  five.minutes.math.drills
//
//  Created by Quantmis on 21/12/2023.
//

import SwiftUI
import Foundation
import CoreData

extension Wallet : Identifiable {
    private static var walletsFetchRequest: NSFetchRequest<Wallet> {
        NSFetchRequest(entityName: "Wallet")
    }
    
    static func all() -> NSFetchRequest<Wallet> {
        let request: NSFetchRequest<Wallet> = walletsFetchRequest
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Wallet.coins,  ascending: false)]
        return request
    }
}

//
//  five_minutes_math_drillsApp.swift
//  five.minutes.math.drills
//
//  Created by Quantmis on 23/11/2023.
//

import SwiftUI

@main
struct five_minutes_math_drillsApp: App {
    @StateObject var navigationStateManager = NavigationStateManager()
    @StateObject var drillSessionStateManager = DrillSessionStateManager(provider:  .shared);

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, CoreDataProvider.shared.viewContext)
                .environmentObject(navigationStateManager)
                .environmentObject(drillSessionStateManager)
        }
    }
}

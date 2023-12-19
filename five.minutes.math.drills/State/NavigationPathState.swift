//
//  NavigationPathState.swift
//  five.minutes.math.drills
//
//  Created by Quantmis on 24/11/2023.
//

import Foundation
import SwiftUI

class NavigationStateManager: ObservableObject {
    @Published var selectionPath = NavigationPath()
    @Published var session:Sessions?
    @Published var questions:[Questions] = []
    func popToRoot() {
        selectionPath = NavigationPath()
    }
   
}

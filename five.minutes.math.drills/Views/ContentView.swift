//
//  ContentView.swift
//  five.minutes.math.drills
//
//  Created by Quantmis on 23/11/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DrillView()
                .tabItem {
                    Label("Exercise", systemImage: "target")
                }
           
        }
        
    }
}

#Preview {
    ContentView()
}

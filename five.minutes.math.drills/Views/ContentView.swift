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
                    Label("My Stuff", systemImage: "shippingbox")
                }
                
            HistoryView()
                .tabItem {
                    Label("Income", systemImage: "dollarsign")
                }
            HistoryView()
                .tabItem {
                    Label("Shops", systemImage: "cart")
                }

            SettingView()
                .tabItem {
                    Label("Setting", systemImage: "gear")
                }
        }.accentColor(.green)
        
    }
}

#Preview {
    ContentView()
}

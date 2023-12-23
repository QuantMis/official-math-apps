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
                    Label("Stickers", systemImage: "paintpalette")
                }
                
            HistoryView()
                .tabItem {
                    Label("Coins", systemImage: "centsign.circle.fill")
                }
            SettingView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }.accentColor(.green)
        
    }
}

#Preview {
    ContentView()
}

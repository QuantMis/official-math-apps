//
//  ContentView.swift
//  five.minutes.math.drills
//
//  Created by Quantmis on 23/11/2023.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isFirstLaunch") private var isFirstLaunch: Bool = true
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    var body: some View {
        Group {
            if isFirstLaunch {
                OnBoardingView(isFirstLaunch: $isFirstLaunch)
            } else {
                TabView {
                    DrillView()
                        .tabItem {
                            Label("stickers".localized(language),
                                  systemImage: "paintpalette")
                        }
                    
                    HistoryView()
                        .tabItem {
                            Label("coins".localized(language),
                                  systemImage: "centsign.circle.fill")
                        }
                    SettingView()
                        .tabItem {
                            Label("settings".localized(language),
                                  systemImage: "gearshape.fill")
                        }
                }.accentColor(.green)
            }
            
        }
    }
}

#Preview {
    ContentView()
}

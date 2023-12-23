//
//  SettingView.swift
//  five.minutes.math.drills
//
//  Created by Quantmis on 19/12/2023.
//

import SwiftUI

struct SettingView: View {
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    @EnvironmentObject var navigationStateManager: NavigationStateManager
    @State private var scoreTarget:Int = 0;
    @AppStorage("dailyTarget") private var dailyTarget: Int = 0
    init() {
        
    }
    
    var body: some View {
        NavigationStack(path: $navigationStateManager.selectionPath) {
            VStack {
                PremiumBannerView()
                Spacer()
                List {
                    //MARK: Main Settings
                    Section(header: Text("Change Language")) {
                        HStack {
                            Text(languageFormatted(_:language.rawValue))
                            Spacer()
                            Menu {
                                Button {
                                    LocalizationService.shared.language = .english_us
                                } label: {
                                    Text("English (US)")
                                }
                                Button {
                                    LocalizationService.shared.language = .chinese_simplified
                                } label: {
                                    Text("Chinese (Simplified)")
                                }
                                Button {
                                    LocalizationService.shared.language = .japanese
                                } label: {
                                    Text("Japanese")
                                }
                                Button {
                                    LocalizationService.shared.language = .deutsch
                                } label: {
                                    Text("German")
                                }
                            } label: {
                                Text(countryCodeToFlagEmoji(_: language.rawValue))
                            }
                        }
                    }
                    
                    //MARK: Support And Resource
                    Section(header: Text("Support and Resources")) {
                        Button(action: {
                            sendFeedback()
                        }) {
                            HStack {
                                Image(systemName: "envelope")
                                Text("Feedback")
                            }
                        }
                        Button(action: {}) {
                            HStack {
                                Text("🙏 Rate the App on AppStore")
                            }
                        }
                    }
                    
                    //MARK: Version
                    Section(header: VStack {
                        HStack {
                            
                            Spacer()
                            Text("Version 1.0.0").textCase(nil).font(.subheadline).foregroundColor(.secondary)
                            Spacer()
                            
                        }
                        
                        HStack {
                            
                            Spacer()
                            Text("Made with ❤️").textCase(nil).font(.subheadline).foregroundColor(.secondary)
                            Spacer()
                            
                        }
                        
                    }
                    ) {
                        
                    }
                }
                
            }
            .onAppear {
                self.dailyTarget = UserDefaults.standard.integer(forKey: "dailyTarget")
                self.scoreTarget = UserDefaults.standard.integer(forKey: "dailyTarget")
            }
        }
    }
    func sendFeedback() {
        let email = "codedancoffee@gmail.com"
        let subject = "Feedback on Math App v1.0"
        
        if let emailURL = URL(string: "mailto:\(email)?subject=\(subject)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") {
            UIApplication.shared.open(emailURL)
        }
    }
    func countryCodeToFlagEmoji(_ language: String) -> String {
        switch language {
        case "en":
            return "🇺🇸"
        case "de":
            return "🇩🇪"
        case "ja":
            return "🇯🇵"
        default:
            return "🇨🇳"
        }
    }
    
    func languageFormatted(_ language: String) -> String {
        switch language {
        case "en":
            return "English (US)"
        case "de":
            return "German"
        case "ja":
            return "Japanese"
        default:
            return "Chinese (Simplified)"
        }
    }
    
}
struct PremiumBannerView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Text("💎 Arithmetic Drill Pro")
                .font(.title)
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity)
            Text("Unlock full exercise history, progress analytics and more!")
                .multilineTextAlignment(.center)
            Text("Learn more")
                .foregroundColor(.primary)
                .padding()
                .background(Color(red: 0, green: 0.7, blue: 0))
                .cornerRadius(10)
        }
        .padding()
        .background(.green)
    }
}


#Preview {
    SettingView().environmentObject(NavigationStateManager())
}

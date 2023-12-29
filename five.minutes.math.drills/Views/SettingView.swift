//
//  SettingView.swift
//  five.minutes.math.drills
//
//  Created by Quantmis on 19/12/2023.
//

import SwiftUI

struct SettingView: View {
    private var language = LocalizationService.shared.language
    @EnvironmentObject var navigationStateManager: NavigationStateManager
    @State private var scoreTarget:Int = 0;
    @AppStorage("dailyTarget") private var dailyTarget: Int = 0
    
    var body: some View {
        NavigationStack(path: $navigationStateManager.selectionPath) {
            VStack {
                ThankYouBanner()
                Spacer()
                List {
                    //MARK: Main Settings
                    Section(header: Text("change_language".localized(language))) {
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
                    Section(header: Text("support".localized(language))) {
                        Button(action: {
                            sendFeedback()
                        }) {
                            HStack {
                                Image(systemName: "envelope")
                                Text("feedback".localized(language))
                            }
                        }
                        Button(action: {
                            if let url = URL(string: "https://apps.apple.com/us/app/math-go-fun-way-to-learn-math/id6475046118") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            HStack {
                                Text("rate_on_appstore".localized(language))
                            }
                        }
                    }
                    
                    //MARK: Version
                    Section(header: VStack {
                        HStack {
                            
                            Spacer()
                            Text("version".localized(language)).textCase(nil).font(.subheadline).foregroundColor(.secondary)
                            Spacer()
                            
                        }
                        
                        HStack {
                            
                            Spacer()
                            Text("made_with".localized(language)).textCase(nil).font(.subheadline).foregroundColor(.secondary)
                            Spacer()
                            
                        }
                        
                    }
                    ) {
                        
                    }
                }
                
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
struct ThankYouBanner: View {
    private var language = LocalizationService.shared.language
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Text("thank_you_title".localized(language))
                .font(.title2)
                .bold()
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            Text("thank_you_sub".localized(language))
                .multilineTextAlignment(.center)
          
            Button(action: {
                if let url = URL(string: "https://apps.apple.com/us/app/math-go-fun-way-to-learn-math/id6475046118") {
                    UIApplication.shared.open(url)
                }
            }) {
                Text("rate_us".localized(language))
                    .foregroundColor(.primary)
                    .padding()
                    .background(Color(red: 0, green: 0.7, blue: 0))
                    .cornerRadius(10)
            }
            
        }
        .padding()
        .background(.green)
    }
}


#Preview {
    SettingView().environmentObject(NavigationStateManager())
}

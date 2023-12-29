//
//  OnBoardingView.swift
//  five.minutes.math.drills
//
//  Created by Quantmis on 24/12/2023.
//

import SwiftUI

struct OnBoardingView: View {
    @Binding var isFirstLaunch: Bool
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Image("student-with-a-math").resizable().frame(width: 300, height: 300)
            HStack {
                Text("Math GO").font(.largeTitle).bold()
                Spacer()
            }
            HStack {
                Text("select_language".localized(language))
                    .font(.title3)
                    .bold()
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
                        .font(.largeTitle)
                }
            }
            Button(action: {
                isFirstLaunch = false
            }, label: {
                HStack {
                    Spacer()
                    Text("continue".localized(language)).font(.title).bold()
                    Spacer()
                }
                .contentShape(Rectangle())
            })
            .buttonStyle(PlainButtonStyle())
            .padding()
            .background(.green)
            .cornerRadius(20)
        }
        .padding()
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



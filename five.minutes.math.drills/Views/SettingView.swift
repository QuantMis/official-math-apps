//
//  SettingView.swift
//  five.minutes.math.drills
//
//  Created by Quantmis on 19/12/2023.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var navigationStateManager: NavigationStateManager
    @State private var scoreTarget:Int = 200;
    
    var body: some View {
        NavigationStack(path: $navigationStateManager.selectionPath) {
            VStack {
                PremiumBannerView()
                Spacer()
                List {
                    //MARK: Main Settings
                    Section(header: Text("Main Setting")) {
                        HStack {
                            Text("Daily Score Target: \(scoreTarget)")
                            Spacer()
                            HStack {
                                Button(action: {
                                    scoreTarget += 10
                                }) {
                                    Image(systemName: "plus")
                                }
                                .buttonStyle(.plain)
                                Spacer().frame(width: 10)
                                Divider()
                                Spacer().frame(width: 10)
                                Button(action: {
                                    scoreTarget = scoreTarget - 10
                                }) {
                                    Image(systemName: "minus")
                                }
                                .buttonStyle(.plain)
                            }
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .background(.tertiary)
                            .cornerRadius(10)
                            
                        }
                        .padding(.top, 3)
                        .padding(.bottom, 3)
                        
                        HStack {
                            Text("Language")
                            Spacer()
                            Text("English")
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
        }
    }
    func sendFeedback() {
        let email = "codedancoffee@gmail.com"
        let subject = "Feedback on Math App v1.0" // Replace with your desired subject
        
        if let emailURL = URL(string: "mailto:\(email)?subject=\(subject)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") {
            UIApplication.shared.open(emailURL)
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
                .foregroundColor(.black)
                .padding()
                .background(Color(red: 0, green: 0.9, blue: 0))
                .cornerRadius(10)
        }
        .padding()
        .background(.green)
    }
}


#Preview {
    SettingView().environmentObject(NavigationStateManager())
}

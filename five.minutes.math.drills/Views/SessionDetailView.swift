//
//  SessionDetailView.swift
//  five.minutes.math.drills
//
//  Created by Quantmis on 13/12/2023.
//

import SwiftUI

struct SessionDetailView: View {
    @EnvironmentObject var nvm: NavigationStateManager
    
    var body: some View {
        List {
            Section() {
                VStack(alignment: .leading) {
                    HStack {
                        Text("\(nvm.session?.startAtWithMinutesFormatted ?? "")").font(.caption).foregroundColor(.gray)
                    }
                    Spacer().frame(height: 5)
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Score").font(.system(size: 16))
                            Text("\(nvm.session?.score ?? 0)")
                                .font(.title3).bold().foregroundColor(.green)
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("Time Taken").font(.system(size: 16))
                            Text("\(nvm.session?.sessionPeriod ?? "")")
                                .font(.title3).bold().foregroundColor(.green)
                        }
                    }
                   
                }
               
                
            }
            Section {
                if (nvm.questions.count > 0) {
                    
                    ForEach(0..<20) { index in
                        HStack {
                            VStack(alignment: .leading) {
                                
                                
                                Text("\(nvm.questions[index].questions ?? "") = \(nvm.questions[index].correct_answer ?? "")").font(.title3).bold()
                                Text("\(nvm.questions[index].user_answer ?? "")").font(.headline).foregroundColor(.secondary).bold()
                            }
                            Spacer()
                            if (nvm.questions[index].correct_answer == nvm.questions[index].user_answer) {
                                Image(systemName: "checkmark").font(.title3).foregroundColor(.green).bold()
                                
                            } else {
                                Image(systemName: "multiply").font(.title3).foregroundColor(.pink).bold()
                            }
                        }
                        
                    }
                }
                
                
                
            }
        }
        .navigationTitle("🎯 Result")
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    nvm.popToRoot()
                }) {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
            }
            
        }
    }
}

#Preview {
    NavigationStack {
        SessionDetailView()
    }
}

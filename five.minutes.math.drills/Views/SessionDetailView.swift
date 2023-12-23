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
                        Text("+ \(nvm.session?.score ?? 0)")
                            .font(.title3).bold().foregroundColor(.green)
                        Image("coin")
                            .resizable()
                            .frame(width: 20, height: 20)
                       
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
                                Image("coin")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                
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

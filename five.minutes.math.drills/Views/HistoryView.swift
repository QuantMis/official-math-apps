//
//  HistoryView.swift
//  five.minutes.math.drills
//
//  Created by Quantmis on 13/12/2023.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var navigationStateManager: NavigationStateManager
    var provider = CoreDataProvider.shared
    @FetchRequest(fetchRequest: Sessions.all()) private var sessions
    
    var body: some View {
        NavigationStack(path: $navigationStateManager.selectionPath) {
            List {
                Section() {
                    
                    ForEach(sessions) { session in
                        Button(action: {
                            navigationStateManager.session = session
                            navigationStateManager.selectionPath.append("session-detail")
                            if let questionsSet = session.questions as? Set<Questions> {
                                let questionsArray = Array(questionsSet)
                                navigationStateManager.questions = questionsArray
                                navigationStateManager.selectionPath.append("session-detail")
                            } else {
                            }
                        }) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("\(session.startAtWithMinutesFormatted)").font(.caption).foregroundColor(.gray)
                                    Spacer()
                                    Image(systemName: "chevron.right").font(.caption).foregroundColor(.gray)
                                    
                                }
                                Spacer().frame(height: 5)
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Score").font(.system(size: 16))
                                        Text("\(session.score)")
                                            .font(.title3).bold().foregroundColor(.green)
                                    }
                                    Spacer()
                                    VStack(alignment: .leading) {
                                        Text("Time Taken").font(.system(size: 16))
                                        Text("\(session.sessionPeriod )")
                                            .font(.title3).bold().foregroundColor(.green)
                                    }
                                }
                               
                            }
                     
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                    }
                }
                
            }
            .navigationDestination(for: String.self) { textValue in
                if (textValue == "session-detail") {
                    SessionDetailView()
                }
                
            }
            .navigationTitle("📝 History")
        }
    }
}

#Preview {
    HistoryView().environmentObject(NavigationStateManager())
}

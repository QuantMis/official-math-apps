//
//  DrillView.swift
//  five.minutes.math.drills
//
//  Created by Quantmis on 23/11/2023.
//

import SwiftUI
import Charts

struct DrillView: View {
    
    @EnvironmentObject var navigationStateManager: NavigationStateManager
    var provider = CoreDataProvider.shared
    @FetchRequest(fetchRequest: Sessions.all()) private var sessions
    @State private var totalScore:Int = 0
    @State private var todayScore:Int = 0
    @State private var progress:Double = 0
    private var defaultTarget:Int = 200
    
    private var title = "🚀 Arithmetic Drill"
    
    var body: some View {
        NavigationStack(path: $navigationStateManager.selectionPath) {
            List {
                Section(header:
                            Text("Progress").textCase(nil).font(.title3).bold().foregroundColor(.primary)
                )
                {
                    HStack(alignment: .center) {
                        VStack(alignment: .leading) {
                            Text("Today Scores").font(.system(size: 16))
                            Text("\(todayScore)/\(defaultTarget)").font(.title3).foregroundColor(.green).bold()
                            Spacer().frame(height: 5)
                            Text("Total Scores").font(.system(size: 16))
                            Text("\(totalScore)").font(.title3).foregroundColor(.gray).bold()
                            Spacer().frame(height: 5)
                            Text("Sessions").font(.system(size: 16))
                            Text("\(sessions.count)").font(.title3).foregroundColor(.gray).bold()
                        }
                        Spacer()
                        CircularProgressView(progress: progress)
                    }
                    .padding(.top, 10)
                    
                }
                Section(header:
                            
                            Text("Exercise").textCase(nil).font(.title3).bold().foregroundColor(.primary)
                        
                )
                {
                    VStack(alignment: .leading, spacing: 10) {
                        Button {
                            navigationStateManager.selectionPath.append("loading-drill-session")
                        } label: {
                            HStack {
                                Text("Start Training")
                                    .font(.headline)
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                         
                        }
                        .foregroundColor(.green)
                        
                    }
                }
             
            }
            .navigationDestination(for: String.self) { textValue in
                if (textValue == "drill") {
                    DrillView()
                }
                if (textValue == "drill-session") {
                    DrillSessionView()
                }
                if (textValue == "loading-drill-session") {
                    LoadingView()
                }
                if (textValue == "session-detail") {
                    SessionDetailView()
                }
                
            }
            .navigationTitle(title)
        }
        .onAppear {
            calculateTotalScore()
            calculateTodayScore()
            calculateProgress()
        }
       
        
        
        .onDisappear {
            totalScore = 0
            todayScore = 0
        }
    }
    
    func calculateTotalScore() {
        for i in 0..<sessions.count {
            totalScore += Int(sessions[i].score)
        }
    }
    
    func calculateTodayScore() {
        for i in 0..<sessions.count {
            if (sessions[i].isToday) {
                todayScore += Int(sessions[i].score)
            }
        }
    }
    
    func calculateProgress() {
        progress = Double(todayScore) / Double(defaultTarget)
    }
}

struct CircularProgressView: View {
    @State private var progress: CGFloat
    let maxValue: CGFloat = 1.0
    init(progress: CGFloat) {
           self._progress = State(initialValue: progress)
       }

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 20.0)
                    .opacity(0.3)
                    .foregroundColor(Color.green.opacity(0.8))

                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.green)
                    .rotationEffect(Angle(degrees: 270.0))

                
            }
            .padding(20.0)
        }
        .frame(width: 130, height: 130)
    }
}


#Preview {
    DrillView().environmentObject(NavigationStateManager())
}

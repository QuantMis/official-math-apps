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
    @State private var defaultTarget:Int = 0
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
                        CircularProgressView(progress: $progress)
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
                                Spacer()
                                Text("Start Training").font(.title2).bold().foregroundColor(.white)
                                Spacer()
                            }
                            
                        }
                        .foregroundColor(.primary)
                    }.listRowBackground(Color.green.opacity(0.8))
                   
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
            getDailyTarget()
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
    
    func getDailyTarget() {
        defaultTarget = UserDefaults.standard.integer(forKey: "dailyTarget")
        
    }
}

struct CircularProgressView: View {
    @Binding var progress: Double
    let maxValue: Double = 1.0
    
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

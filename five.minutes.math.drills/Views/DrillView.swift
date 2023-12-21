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
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    HStack(alignment: .center) {
                        Image("coin")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text("\(totalScore)").font(.largeTitle).foregroundColor(.secondary).bold()
                        
                    }
                    Spacer()
                }
                HStack {
                    Text("My Stuffs").font(.title3).bold()
                    Image("cubes")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Spacer()
                    HStack {
                        Text("Shop").font(.title3)
                            .fontWeight(.semibold)
                        Image("online-shopping")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                }
                Spacer()
                HStack(alignment: .center) {
                    Spacer()
                    Text("You don't have any stuffs yet. Earn coins and buy item at shop").font(.title).foregroundColor(.secondary).multilineTextAlignment(.center)
                    Spacer()
                }
                Spacer()
                VStack(alignment: .leading, spacing: 10) {
                    Button {
                        navigationStateManager.selectionPath.append("loading-drill-session")
                    } label: {
                        HStack {
                            Spacer()
                            Text("Earn Coins").font(.title2).bold().foregroundColor(.white)
                            Spacer()
                        }
                        
                    }
                    .foregroundColor(.primary)
                }
                .padding()
                .background(.green)
                .cornerRadius(20)
                Spacer().frame(height: 20)
            }
            .padding()
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

//
//  LoadingView.swift
//  five.minutes.math.drills
//
//  Created by Quantmis on 24/11/2023.
//

import SwiftUI

struct LoadingView: View {
    @EnvironmentObject var navigationStateManager: NavigationStateManager
    @EnvironmentObject var drillSessionStateManager: DrillSessionStateManager
    private var language = LocalizationService.shared.language
    @State private var isLoading:Bool = true
    @State private var countdown:Int = 1
    
    var body: some View {
        VStack {
            HStack {
                if isLoading {
                    SpinnerView()
                    Spacer().frame(width: 5)
                }
                Text("loading".localized(language)).font(.title3)
            }
            if !isLoading {
                if countdown != 0 {
                    Text("\(countdown)").font(.largeTitle).bold()
                } else {
                    Text("Go").font(.largeTitle).bold()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .onAppear {
            startCountdown()
        }
    }
    func startCountdown() {
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            countdown -= 1
            if countdown == 0 {
                timer.invalidate()
                navigationStateManager.selectionPath.append("drill-session")
                drillSessionStateManager.initiateSession()
            }
        }
        RunLoop.main.add(timer, forMode: .common)
    }
}

struct SpinnerView: View {
  var body: some View {
    ProgressView()
      .progressViewStyle(CircularProgressViewStyle(tint: .gray))
      .scaleEffect(1.0, anchor: .center)
  }
}


#Preview {
    LoadingView()
}

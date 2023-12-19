//
//  DrillSessionView.swift
//  five.minutes.math.drills
//
//  Created by Quantmis on 24/11/2023.
//

import SwiftUI

struct DrillSessionView: View {
    @EnvironmentObject var navigationStateManager: NavigationStateManager
    @EnvironmentObject var sessionStateManager: DrillSessionStateManager
    var body: some View {
        VStack {
            // MARK: Exit Button
            Button {
                navigationStateManager.popToRoot()
            } label: {
                HStack {
                    Image(systemName: "multiply.circle")
                    Text("End Session")
                    Spacer()
                }
            }
            .buttonStyle(PlainButtonStyle())
            
            Spacer()
            
            // MARK: Question
            VStack {
                // MARK: Questions Info
                Text("\(sessionStateManager.getCurrentQuestionIndex()) of \(sessionStateManager.questions.count)").font(.title3)
                Spacer().frame(height: 10)
                // MARK: Questions
                Text("\(sessionStateManager.getCurrentQuestion().questions ?? "")")
                    .font(.system(size: 50)).bold()
            }
            
            Spacer()
            
            // MARK: Answer
            HStack {
                ForEach(generateAnswer(answer: sessionStateManager.getCurrentQuestion().correct_answer ?? "0"), id: \.self) { answer in
                    Button {
                        userChooseAnswer(answer: answer)
                    } label: {
                        Rectangle()
                            .fill(.green)
                            .frame(width: 80, height: 70)
                            .cornerRadius(20)
                            .overlay {
                                Text(answer).font(.title)
                            }
                        
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)

    }
    
    func userChooseAnswer(answer: String) {
        sessionStateManager.chooseAnswer(answer: answer)
        if (sessionStateManager.questionIndex < sessionStateManager.questions.count - 1) {
            withAnimation(.none) {
                sessionStateManager.incrementQuestionIndex()
            }
        } else {
            sessionStateManager.finishedSession()
            navigationStateManager.session = sessionStateManager.session
            navigationStateManager.questions = sessionStateManager.questions
            navigationStateManager.selectionPath.append("session-detail")
        }
    }
}

#Preview {
    DrillSessionView()
}

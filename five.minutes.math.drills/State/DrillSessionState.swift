//
//  DrillSessionState.swift
//  five.minutes.math.drills
//
//  Created by Quantmis on 24/11/2023.
//

import Foundation
import SwiftUI
import CoreData

class DrillSessionStateManager: ObservableObject {
    private let context: NSManagedObjectContext
    @Published var session: Sessions?
    @Published var questions: [Questions]
    @Published var questionIndex:Int = 0
    
    init(provider: CoreDataProvider) {
        self.context = provider.newContext
        self.questions = []
    }
    
    func initiateSession() {
        clearSession()
        session = Sessions(context: context)
        session!.status = 0
        session!.start_at = Int64(Date().timeIntervalSince1970)
        session!.score = 0
        questions = generateQuestions(context: context)
    }
    
    
    func finishedSession() {
        for i in 0..<questions.count {
            session!.end_at = Int64(Date().timeIntervalSince1970)
            session!.addToQuestions(questions[i])
            session!.status = 1
            
            // calculate session marks
            if (questions[i].correct_answer == questions[i].user_answer) {
                session!.score += 1
            }
        }
        do {
            try context.save()
        } catch {
        }
    }
    
    func clearSession() {
        questions = []
        questionIndex = 0
    }
    
    func incrementQuestionIndex() {
        questionIndex += 1
    }
    
    func getCurrentQuestion() -> Questions {
        return questions[questionIndex]
    }
    
    func chooseAnswer(answer:String) {
        questions[questionIndex].user_answer = answer
    }
    
    func getCurrentQuestionIndex() -> String {
        var currentQuestionIndex = questionIndex
        currentQuestionIndex += 1
        return String(currentQuestionIndex)
    }
    
    
    
    
}

//
//  AnswerGenerator.swift
//  five.minutes.math.drills
//
//  Created by Quantmis on 25/11/2023.
//

import Foundation

// MARK: - Public Interface

func generateAnswer(answer: String) -> [String] {
    var answers: [String] = [answer]

    repeat {
        answers = removeDuplicates(answers)
        let answerInt = convertToInt(answer)
        let newAnswer = generateRandomVariation(answerInt)
        answers.append(removeLeadingZero(newAnswer))
    } while (answers.count < 4 || !areElementsUnique(answers))

    return answers
}

// MARK: - Variation Functions

func incrementVariation(_ answer: Int) -> String {
    return String(answer + 1)
}

func decrementVariation(_ answer: Int) -> String {
    return String(answer - 1)
}

func mirrorImageVariation(_ answer: Int) -> String {
    return String(String(answer).reversed())
}

func doubleVariation(_ answer: Int) -> String {
    return String(answer * 2)
}

func addTenVariation(_ answer: Int) -> String {
    return String(answer + 10)
}

func minusTenVariation(_ answer: Int) -> String {
    return String(answer - 10)
}

func rotateDigitsVariation(_ n: Int) -> String {
    let rotatedStr = String(String(n).suffix(1) + String(n).dropLast(1))
    return rotatedStr
}

// MARK: - Helper Functions

func convertToInt(_ answer: String) -> Int {
    return Int(answer) ?? 0
}

func generateRandomVariation(_ answer: Int) -> String {
    let dice = Int.random(in: 1...7)
    switch dice {
    case 1: return incrementVariation(answer)
    case 2: return decrementVariation(answer)
    case 3: return mirrorImageVariation(answer)
    case 4: return doubleVariation(answer)
    case 5: return addTenVariation(answer)
    case 6: return minusTenVariation(answer)
    default: return rotateDigitsVariation(answer)
    }
}

//
//  QuestionGenerator.swift
//  five.minutes.math.drills
//
//  Created by Quantmis on 25/11/2023.
//

import Foundation
import CoreData

func generateQuestions(context: NSManagedObjectContext) -> [Questions] {
    let additionQuestions: [Questions] = addition(context: context)
    let substractionQuestions: [Questions] = substraction(context: context)
    let multiplicationQuestions: [Questions] = multiplication(context: context)
    let divisionQuestions: [Questions] = division(context: context)
    return additionQuestions + substractionQuestions + multiplicationQuestions + divisionQuestions;
}

func addition(context: NSManagedObjectContext) -> [Questions] {
    var additions: [Questions] = []
    
    // MARK: Q1
    let q1 = Questions(context: context)
    let q1d1 = Int.random(in: 1...9)
    let q1d2 = Int.random(in: 1...9)
    let q1ans = q1d1 + q1d2
    q1.correct_answer = String(q1ans)
    q1.questions = "\(q1d1) + \(q1d2)"
    additions.append(q1)
    
    // MARK: Q2
    let q2 = Questions(context: context)
    let q2d1 = Int.random(in: 11...25)
    let q2d2 = Int.random(in: 11...25)
    let q2ans = q2d1 + q2d2
    q2.correct_answer = String(q2ans)
    q2.questions = "\(q2d1) + \(q2d2)"
    additions.append(q2)
    
    // MARK: Q3
    let q3 = Questions(context: context)
    let q3d1 = Int.random(in: 26...50)
    let q3d2 = Int.random(in: 26...99)
    let q3ans = q3d1 + q3d2
    q3.correct_answer = String(q3ans)
    q3.questions = "\(q3d1) + \(q3d2)"
    additions.append(q3)
    
    // MARK: Q4
    let q4 = Questions(context: context)
    let q4d1 = Int.random(in: 1...9)
    let q4d2 = Int.random(in: 1...25)
    let q4d3 = Int.random(in: 1...25)
    let q4ans = q4d1 + q4d2 + q4d3
    q4.correct_answer = String(q4ans)
    q4.questions = "\(q4d1) + \(q4d2) + \(q4d3)"
    additions.append(q4)
    
    // MARK: Q5
    let q5 = Questions(context: context)
    let q5d1 = Int.random(in: 1...25)
    let q5d2 = Int.random(in: 1...50)
    let q5d3 = Int.random(in: 1...99)
    let q5ans = q5d1 + q5d2 + q5d3
    q5.correct_answer = String(q5ans)
    q5.questions = "\(q5d1) + \(q5d2) + \(q5d3)"
    additions.append(q5)
    
    return additions
}

func substraction(context: NSManagedObjectContext) -> [Questions] {
    var substraction: [Questions] = []
    // MARK: Q1
    let q1 = Questions(context: context)
    let q1d1 = Int.random(in: 1...9)
    let q1d2 = Int.random(in: 1...9)
    let dArr = [q1d1, q1d2].sorted(by: >)
    let q1ans = dArr[0] - dArr[1]
    q1.correct_answer = String(q1ans)
    q1.questions = "\(dArr[0]) - \(dArr[1])"
    substraction.append(q1)
    
    // MARK: Q2
    let q2 = Questions(context: context)
    let q2d1 = Int.random(in: 11...25)
    let q2d2 = Int.random(in: 11...25)
    let q2dArr = [q2d1, q2d2].sorted(by: >)
    let q2ans = q2dArr[0] - q2dArr[1]
    q2.correct_answer = String(q2ans)
    q2.questions = "\(q2dArr[0]) - \(q2dArr[1])"
    substraction.append(q2)
    
    // MARK: Q3
    let q3 = Questions(context: context)
    let q3d1 = Int.random(in: 11...50)
    let q3d2 = Int.random(in: 11...50)
    let q3dArr = [q3d1, q3d2].sorted(by: >)
    let q3ans = q3dArr[0] - q3dArr[1]
    q3.correct_answer = String(q3ans)
    q3.questions = "\(q3dArr[0]) - \(q3dArr[1])"
    substraction.append(q3)
    
    // MARK: Q4
    let q4 = Questions(context: context)
    let q4d1 = Int.random(in: 11...99)
    let q4d2 = Int.random(in: 11...99)
    let q4dArr = [q4d1, q4d2].sorted(by: >)
    let q4ans = q4dArr[0] - q4dArr[1]
    q4.correct_answer = String(q4ans)
    q4.questions = "\(q4dArr[0]) - \(q4dArr[1])"
    substraction.append(q4)
    
    // MARK: Q5
    let q5 = Questions(context: context)
    let q5d1 = Int.random(in: 50...99)
    let q5d2 = Int.random(in: 25...50)
    let q5d3 = Int.random(in: 1...9)
    let q5ans = q5d1 - q5d2 - q5d3
    q5.correct_answer = String(q5ans)
    q5.questions = "\(q5d1) - \(q5d2) - \(q5d3)"
    substraction.append(q5)

    return substraction
}

func multiplication(context: NSManagedObjectContext) -> [Questions] {
    var multiplications: [Questions] = []
    
    // MARK: Q1
    let q1 = Questions(context: context)
    let q1d1 = Int.random(in: 2...4)
    let q1d2 = Int.random(in: 2...6)
    let q1ans = q1d1 * q1d2
    q1.correct_answer = String(q1ans)
    q1.questions = "\(q1d1) x \(q1d2)"
    multiplications.append(q1)
    
    // MARK: Q2
    let q2 = Questions(context: context)
    let q2d1 = Int.random(in: 2...9)
    let q2d2 = Int.random(in: 2...9)
    let q2ans = q2d1 * q2d2
    q2.correct_answer = String(q2ans)
    q2.questions = "\(q2d1) x \(q2d2)"
    multiplications.append(q2)
    
    // MARK: Q3
    let q3 = Questions(context: context)
    let q3d1 = Int.random(in: 9...12)
    let q3d2 = Int.random(in: 9...12)
    let q3ans = q3d1 * q3d2
    q3.correct_answer = String(q3ans)
    q3.questions = "\(q3d1) x \(q3d2)"
    multiplications.append(q3)
    
    // MARK: Q4
    let q4 = Questions(context: context)
    let q4d1 = Int.random(in: 2...5)
    let q4d2 = Int.random(in: 2...5)
    let q4d3 = Int.random(in: 2...5)
    let q4ans = q4d1 * q4d2 * q4d3
    q4.correct_answer = String(q4ans)
    q4.questions = "\(q4d1) x \(q4d2) x \(q4d3)"
    multiplications.append(q4)
    
    // MARK: Q5
    let q5 = Questions(context: context)
    let q5d1 = Int.random(in: 2...5)
    let q5d2 = Int.random(in: 4...6)
    let q5d3 = Int.random(in: 3...9)
    let q5ans = q5d1 * q5d2 * q5d3
    q5.correct_answer = String(q5ans)
    q5.questions = "\(q5d1) x \(q5d2) x \(q5d3)"
    multiplications.append(q5)

    return multiplications

}

func division(context: NSManagedObjectContext) -> [Questions] {
    var divisions: [Questions] = []
    
    // MARK: Q1
    let q1 = Questions(context: context)
    let q1deno = Int.random(in: 2...3)
    let q1nume = q1deno * Int.random(in: 2...5)
    let q1ans = q1nume / q1deno
    q1.correct_answer = String(q1ans)
    q1.questions = "\(q1nume) / \(q1deno)"
    divisions.append(q1)
    
    // MARK: Q2
    let q2 = Questions(context: context)
    let q2deno = Int.random(in: 2...5)
    let q2nume = q2deno * Int.random(in: 2...5)
    let q2ans = q2nume / q2deno
    q2.correct_answer = String(q2ans)
    q2.questions = "\(q2nume) / \(q2deno)"
    divisions.append(q2)
    
    // MARK: Q3
    let q3 = Questions(context: context)
    let q3deno = Int.random(in: 4...6)
    let q3nume = q3deno * Int.random(in: 2...5)
    let q3ans = q3nume / q3deno
    q3.correct_answer = String(q3ans)
    q3.questions = "\(q3nume) / \(q3deno)"
    divisions.append(q3)
    
    // MARK: Q4
    let q4 = Questions(context: context)
    let q4deno = Int.random(in: 6...9)
    let q4nume = q4deno * Int.random(in: 2...5)
    let q4ans = q4nume / q4deno
    q4.correct_answer = String(q4ans)
    q4.questions = "\(q4nume) / \(q4deno)"
    divisions.append(q4)
    
    // MARK: Q5
    let q5 = Questions(context: context)
    let q5deno = Int.random(in: 6...9)
    let q5nume = q5deno * Int.random(in: 2...5)
    let q5ans = q5nume / q5deno
    q5.correct_answer = String(q5ans)
    q5.questions = "\(q5nume) / \(q5deno)"
    divisions.append(q5)

    return divisions
}

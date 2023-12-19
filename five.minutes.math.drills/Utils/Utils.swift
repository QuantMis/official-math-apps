//
//  Utils.swift
//  five.minutes.math.drills
//
//  Created by Quantmis on 08/12/2023.
//

import Foundation
func areElementsUnique<T: Hashable>(_ array: [T]) -> Bool {
    let set = Set(array)
    return array.count == set.count
}

func removeDuplicates<T: Hashable>(_ array: [T]) -> [T] {
    let set = Set(array)
    return Array(set)
}

func removeLeadingZero(_ input: String) -> String {
    var result = input
    if (result.count > 1) {
        while result.hasPrefix("0") {
            result.removeFirst()
        }
    }
    return result
}

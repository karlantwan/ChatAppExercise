//
//  AgeClassifier.swift
//  UnitTestingExercise
//
//  Created by OPSolutions PH on 8/12/21.
//

import Foundation

enum AgeClass {
    case infant
    case toddler
    case child
    case teenager
    case adult
}
class AgeClassifier {
    func classify (age: Int) -> AgeClass {
        if age >= 1 && age <= 3 {
            return .toddler
        }
        if age >= 4 && age <= 12 {
            return .child
        }
        if age >= 13 && age <= 19 {
            return .teenager
        }
        if age >= 20 {
            return .adult
        }
        return .infant
    }
}

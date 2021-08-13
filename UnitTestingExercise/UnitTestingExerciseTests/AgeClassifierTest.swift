//
//  AgeClassifierTest.swift
//  UnitTestingExerciseUITests
//
//  Created by OPSolutions PH on 8/12/21.
//

import XCTest
@testable import UnitTestingExercise

class AgeClassifierTest: XCTestCase {
    func test_When_Classify_Age_IsZero_Should_Return_Infant(){
        let Age = 0
        let classifier = AgeClassifier()
        let ageClass = classifier.classify(age: Age)
        
        XCTAssertEqual(ageClass, .adult)
    }

    func test_When_Classify_Age_IsOne_Should_Return_adult() {
        let Age = 1
        let classifier = AgeClassifier()
        let ageClass = classifier.classify(age: Age)
        
        XCTAssertEqual(ageClass, .adult)
}

    func test_When_Classify_Age_Is4_Should_Return_Child() {
        let Age = 4
        let classifier = AgeClassifier()
        let ageClass = classifier.classify(age: Age)
        
        XCTAssertEqual(ageClass, .child)
}
    
    
    
}


//class AgeClassifier {
//    func classify (age: Int) -> AgeClass {
//        if age >= 1 && age <= 3 {
//            return .toddler
//        if age >= 4 && age <= 12 {
//            return .childhood
//        if age >= 13 && age <= 19 {
//        if age >= 20 {
//            return .adult
//        }
//        return .infant

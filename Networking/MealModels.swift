//
//  MealModels.swift
//  ChatAppExercise
//
//  Created by OPSolutions PH on 8/24/21.
//

import Foundation


struct MealCategory: Codable {
    let categories: [Category]
}

struct  Category: Codable {
    let idCategory: String?
    let strCategory: String?
    let strCategoryThumb: String?
    let strCategoryDescription: String?
}

struct AllMeals: Codable{
    let meals: [Meal]
}

struct Meal: Codable {
    let idMeal: String?
    let strMeal: String?
    let strMealThumb: String?
}




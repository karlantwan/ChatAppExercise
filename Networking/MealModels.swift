//
//  MealModels.swift
//  ChatAppExercise
//
//  Created by OPSolutions PH on 8/24/21.
//

import Foundation

struct MealCategories: Codable {
    let categories: [categories]

}

struct  categories: Codable {
    let idCategory: String?
    let strCategory: String?
    let strCategoryThumb: String?
}

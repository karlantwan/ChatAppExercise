//
//  APIModels.swift
//  MyAppDemonstration
//
//  Created by OPSolutions PH on 8/16/21.
//

import Foundation

struct Todo: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

struct Album: Codable {
    let userId: Int
    let id: Int
    let title: String
}

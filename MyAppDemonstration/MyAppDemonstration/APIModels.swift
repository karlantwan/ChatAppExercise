//
//  APIModels.swift
//  MyAppDemonstration
//
//  Created by OPSolutions PH on 8/11/21.
//

import Foundation

struct Photos: Codable {
    let alt_description: String?
    let urls: Url
}
struct Url: Codable {
    var regular: String
}

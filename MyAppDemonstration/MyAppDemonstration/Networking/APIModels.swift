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
    let user: User
}
struct Url: Codable {
    var regular: String
    var thumb: String
}
struct User: Codable {
    let name: String
    let profileImage: ProfileImage
    
    enum CodingKeys: String, CodingKey {
        case name, profileImage = "profile_image"
    }
}

struct ProfileImage: Codable {
    let medium: String
}

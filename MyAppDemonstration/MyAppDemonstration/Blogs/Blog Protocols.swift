//
//  Blog Protocols.swift
//  MyAppDemonstration
//
//  Created by OPSolutions PH on 8/16/21.
//

import Foundation


protocol API {
    func fetchPosts()
}

protocol DelegateBlogProtocol {
    func didReceive(models: [Codable])
}

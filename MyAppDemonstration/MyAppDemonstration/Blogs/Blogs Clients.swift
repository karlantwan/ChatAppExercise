//
//  Blogs Clients.swift
//  MyAppDemonstration
//
//  Created by OPSolutions PH on 8/16/21.
//

import Foundation

class Client: DelegateProtocol {
    func didReceive(models: [Codable]) {
        debugPrint(models)
    }
}

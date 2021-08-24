//
//  Networking.swift
//  ChatAppExercise
//
//  Created by OPSolutions PH on 8/24/21.
//

import Foundation

//www.themealdb.com/api/json/v1/1/categories.php

struct UnsplashAPIEndpoints {
    static let categories = "categories"
}

let baseURL = "www.themealdb.com/api/json/v1/1/categories.php"

enum ParserError: Error {
    case failed(String)
}

enum APIError: Error{
    case apiFailed (String)
    case parsingFailed (String)
}

class Networking {
    var delegate: DelegateProtocol?
    
    func fetch(resource: String, orderBy: String, completionHandler: @escaping (Data?, URLResponse?, String?) -> Void) {
        
        let session = URLSession(configuration: .default)
        let url = URL(string: "\(baseURL)")
        print(url!)
        guard let url = url else {
            return
        }
        
        let task = session.dataTask(with: url) {data, response, error in completionHandler(data, response, error?.localizedDescription)
        }
        
        task.resume()
    }
}

    struct JSONParser {
        // Input Data
        // Expected output -> either and error or valid model
        
        func parse<Model: Codable>(data: Data, completionHandler: @escaping ([Model]?, Error?) -> Void) {
            do {
                let jsonDecoder = JSONDecoder()
                
                let models = try jsonDecoder.decode([Model].self, from: data)
                
                DispatchQueue.main.async {
                    completionHandler(models, nil)
                }
            } catch {
                completionHandler(nil, ParserError.failed(error.localizedDescription))
            }
        }
    }

class CategorySourceAPI {
    let networking = Networking()
    
    func fetchMealCategories(orderBy: String, resultBlock: @escaping ([MealCategories]?, APIError?) -> Void) {
        networking.fetch(resource: UnsplashAPIEndpoints.categories, orderBy: orderBy) { data, _, errorMessage in
        
            if let error = errorMessage {
                resultBlock(nil, APIError.apiFailed(error))
                return
            }
            
            guard let data = data else {
                resultBlock(nil, APIError.apiFailed(errorMessage ?? "Unknown error"))
                return
            }
            
            let parser = JSONParser()

            parser.parse(data: data) { (categories: [MealCategories]?, error: Error?) in
                
                if error != nil {
                    resultBlock(nil, APIError.parsingFailed(error?.localizedDescription ?? "Parsing failed"))
                }
                
                guard let categories = categories else {
                    resultBlock(nil, APIError.parsingFailed("Entity is empty"))
                    return
                }
                resultBlock(categories, nil)
            }
        }
    }
}

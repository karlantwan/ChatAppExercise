//
//  Networking.swift
//  MyAppDemonstration
//
//  Created by OPSolutions PH on 8/11/21.
//

import Foundation

struct UnsplashAPIEndpoints {
    static let photos = "photos"
}

let baseURL = "https://api.unsplash.com/"

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
        let url = URL(string: "\(baseURL)/\(resource)?page=\(orderBy)&per_page=20&order_by=latest&client_id=\(APIKey)")
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

class PhotoSourceAPI {
    let networking = Networking()
    
    func fetchPhotos(orderBy: String, resultBlock: @escaping ([Photos]?, APIError?) -> Void) {
        networking.fetch(resource: UnsplashAPIEndpoints.photos, orderBy: orderBy) { data, _, errorMessage in
        
            if let error = errorMessage {
                resultBlock(nil, APIError.apiFailed(error))
                return
            }
            
            guard let data = data else {
                resultBlock(nil, APIError.apiFailed(errorMessage ?? "Unknown error"))
                return
            }
            
            let parser = JSONParser()

            parser.parse(data: data) { (photos: [Photos]?, error: Error?) in
                
                if error != nil {
                    resultBlock(nil, APIError.parsingFailed(error?.localizedDescription ?? "Parsing faled"))
                }
                
                guard let photos = photos else {
                    resultBlock(nil, APIError.parsingFailed("Photos empty"))
                    return
                }
                resultBlock(photos, nil)
            }
        }
    }
}

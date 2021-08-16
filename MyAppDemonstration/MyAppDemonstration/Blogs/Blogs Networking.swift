//
//  NetworkingBlogs.swift
//  MyAppDemonstration
//
//  Created by OPSolutions PH on 8/16/21.
//

import Foundation

let blogURL = "https://jsonplaceholder.typicode.com"


class BlogNetworking: API {
    var delegate: DelegateBlogProtocol?
    
    func fetch<Model: Codable>(resource: String, model: Model.Type, completionHandler: @escaping ([Codable]) -> Void) {
        
        let session = URLSession(configuration: .default)
        let url = URL(string: "\(blogURL)/\(resource)")
        
        guard let url = url else {
            return
        }
        
        let task = session.dataTask(with: url) { data, _, error in
            do {
                let jsonDecoder = JSONDecoder()
                
                let models = try jsonDecoder.decode([Model].self, from: data!)
                
                DispatchQueue.main.async { [self] in
                    delegate?.didReceive(models: models)
                    completionHandler(models)
                }
                
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
    
    func fetchPosts() {
        //https://jsonplaceholder.typicode..com/albums
        let session = URLSession(configuration: .default)
        let url = URL(string: "\(baseURL)/albums")
        
        guard let url = url else {
            return
        }
        
        let task = session.dataTask(with: url) { data, _, error in
            do {
                let jsonDecoder = JSONDecoder()
                
                let albums = try jsonDecoder.decode([Album].self, from: data!)
                
                for album in albums {
                    print("Title: \(album.title)")
                }
            }catch {
                print(error)
            }
        }
        
        task.resume()
    }
    
    func fetchTodos() {
        let session = URLSession(configuration: .default)
        let url = URL(string: "\(baseURL)/todos")
        
        guard let url = url else {
            return
        }
        
        let task = session.dataTask(with: url) { data, _, error in
            do {
                let jsonDecoder = JSONDecoder()
                let todos = try jsonDecoder.decode([Todo].self, from: data!)
                for todo in todos {
                    print("Id \(todo.id) \n title \(todo.title)")
                }
            }catch {
                print(error)
            }
        }
        
        task.resume()
    }
}

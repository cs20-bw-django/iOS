//
//  APIController.swift
//  AdventureGame
//
//  Created by Angel Buenrostro on 8/29/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkError: Error {
    case noAuth
    case badAuth
    case otherError
    case badData
    case noDecode
}

class APIController {
    
    //private let baseURL = URL(string: "https://lambda-mud-test.herokuapp.com/api")!
    private let baseURL = URL(string: "https://csbw-1.herokuapp.com/api")!
    var bearer: Bearer?
    
    func signUp(with user: UserRegister, completion: @escaping(Error?) -> Void) {
        let signUpURL = baseURL.appendingPathComponent("registration/")
        
        var request = URLRequest(url: signUpURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpShouldHandleCookies = false
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(user)
            request.httpBody = jsonData
        } catch {
            print("Error encoding user object:\(error)")
            completion(error)
            return
        }
        // Make Network Request
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(NSError())
                return
            }
            
            let decoder = JSONDecoder()
            do {
                self.bearer = try decoder.decode(Bearer.self, from: data)
            } catch {
                print("Error decoding bearer object: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            completion(nil)
        }.resume()
    }
    
    
    func signIn(with user: UserLogin, completion: @escaping (Error?) -> ()) {
        let loginURL = baseURL.appendingPathComponent("login/")
        
        print(loginURL)
        
        var request = URLRequest(url: loginURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpShouldHandleCookies = false
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(user)
            request.httpBody = jsonData
        } catch {
            print("Error encoding user object: \(error)")
            completion(error)
            return
        }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(NSError(domain: "", code: response.statusCode, userInfo:nil))
                return
            }
            
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(NSError())
                return
            }
            
            let decoder = JSONDecoder()
            do {
                self.bearer = try decoder.decode(Bearer.self, from: data)
                print("token is: \(self.bearer!.key)")
            } catch {
                print("Error decoding bearer object: \(error)")
                completion(error)
                return
            }
            
            completion(nil)
            }.resume()
    }
    
    func initialize(completion: @escaping (Result<GameState, NetworkError>) -> Void) {
        guard let bearer = bearer else {
            completion(.failure(.noAuth))
            return
        }
        
        let initializeURL = baseURL.appendingPathComponent("adv/init/")
        print(initializeURL)
        
        var request = URLRequest(url: initializeURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.addValue("Token \(bearer.key)", forHTTPHeaderField: "Authorization")
        print("Token \(bearer.key)")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                completion(.failure(.badAuth))
                return
            }
            
            if let _ = error {
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            let jsonDecoder = JSONDecoder()
            do {
                let gameState = try jsonDecoder.decode(GameState.self, from: data)
                completion(.success(gameState))
            } catch {
                completion(.failure(.noDecode))
            }
        }.resume()
    }
    
    func move(direction: String, completion: @escaping(Result<GameState, NetworkError>) -> Void) {
        guard let bearer = bearer else {
            completion(.failure(.noAuth))
            return
        }
        
        let moveURL = baseURL.appendingPathComponent("adv/move/")
        
        var request = URLRequest(url: moveURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("Token \(bearer.key)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpShouldHandleCookies = false
        
        // JSON Body
        
        let bodyObject: [String : Any] = [
            "direction": direction
        ]
        request.httpBody = try! JSONSerialization.data(withJSONObject: bodyObject, options: [])
        
        // Make network request
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(.failure(.otherError))
                return
            }
            
            if let _ = error {
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let gameState = try decoder.decode(GameState.self, from: data)
                completion(.success(gameState))
            } catch {
                completion(.failure(.noDecode))
            }
        }.resume()
    }
}

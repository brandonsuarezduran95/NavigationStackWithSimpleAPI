//
//  Network.swift
//  NavigationStackWithSimpleAPI
//
//  Created by Brandon Suarez on 5/4/23.
//

import Foundation

import SwiftUI

enum NetworkError: String, Error {
    case badURL = "Bad URL"
    case badServerResponse = "Bad Server Response"
}

class Network {
    
    let sessionHandler: SessionHandler
    let parserHandler: ParserHandler
    
    init(sessionHandler: SessionHandler = SessionHandler(), parserHandler: ParserHandler = ParserHandler()) {
        self.sessionHandler = sessionHandler
        self.parserHandler = parserHandler
    }
    
    func getData(completion: @escaping (Result<[User], NetworkError>) -> Void ) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            print(NetworkError.badURL.rawValue)
            return
        }
        sessionHandler.createSession(url: url) { sessionResult in
            switch sessionResult {
            case .success(let sessionData):
                self.parserHandler.parseData(data: sessionData) { parsingResult in
                    switch parsingResult {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let parsingError):
                        completion(.failure(parsingError))
                    }
                }
                
            case .failure(let sessionError):
                completion(.failure(sessionError))
            }
        }
    }
}

class SessionHandler {
    func createSession(url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil  else {
                return completion(.failure(NetworkError.badURL))
            }
            completion(.success(data))
        }.resume()
    }
}

class ParserHandler {
    func parseData(data: Data, completion: @escaping (Result<[User], NetworkError>) -> Void) {
        do {
            let data = try JSONDecoder().decode([User].self, from: data)
            print(data)
            return completion(.success(data))
        } catch {
            return completion(.failure(NetworkError.badServerResponse))
        }
    }
}

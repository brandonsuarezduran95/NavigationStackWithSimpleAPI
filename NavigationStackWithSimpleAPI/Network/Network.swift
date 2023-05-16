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
    
    func getData(completion: @escaping (Result<[User], NetworkError>) -> Void ) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            print(NetworkError.badURL.rawValue)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(NetworkError.badURL))
            }
            
            do {
                let data = try JSONDecoder().decode([User].self, from: data!)
                print(data)
                completion(.success(data))
            } catch {
                completion(.failure(NetworkError.badServerResponse))
            }
        }.resume()
    }
}

class Router: ObservableObject {
    @Published var users: [User] = []
    
    func getData() {
        Network().getData { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.users = data
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
}

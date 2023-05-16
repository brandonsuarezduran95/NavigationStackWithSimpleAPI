//
//  Router.swift
//  NavigationStackWithSimpleAPI
//
//  Created by Brandon Suarez on 5/16/23.
//

import Foundation
import SwiftUI

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

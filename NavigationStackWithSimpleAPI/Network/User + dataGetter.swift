//
//  User + dataGetter.swift
//  NavigationStackWithSimpleAPI
//
//  Created by Brandon Suarez on 5/6/23.
//

import Foundation

struct UserDataGetter {
    let user: User
    
    func getData() -> [String] {
        let userName = "UserName: \(user.name)"
        let email = "Email: \(user.email)"
        let phone = "Phone: \(user.phone)"
        let website = "Website: \(user.website)"
        
        return [userName, email, phone, website]
    }
}

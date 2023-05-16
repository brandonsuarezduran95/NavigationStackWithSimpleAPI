//
//  Model.swift
//  NavigationStackWithSimpleAPI
//
//  Created by Brandon Suarez on 5/4/23.
//

import Foundation


struct User: Codable, Hashable, Identifiable {
    var id: Int
    var name: String
    var username: String
    var email: String
    var address: Address
    var phone: String
    var website: String
    var company: Company
}

struct Address: Codable, Hashable {
    var street: String
    var suite: String
    var city: String
    var zipcode: String
}

struct geoLocation: Codable, Hashable {
    var lat: String
    var lng: String
}

struct Company: Codable, Hashable {
    var name: String
    var catchPhrase: String
    var bs: String
}



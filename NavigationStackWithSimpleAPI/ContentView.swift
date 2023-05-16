//
//  ContentView.swift
//  NavigationStackWithSimpleAPI
//
//  Created by Brandon Suarez on 5/4/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var router = Router()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(router.users , id: \.id) { user in
                    NavigationLink(value: user) {
                        Text(user.name)
                    }
                }
            }
            .navigationTitle("User")
            .onAppear {
                router.getData()
            }
            .navigationDestination(for: User.self) { user in
                // Cell
                UserCellView(user: user)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct UserCellView: View {
    private let user: User
    private let userData: [String]
    
    init(user: User) {
        self.user = user
        self.userData = UserDataGetter(user: user).getData()
    }
    
    var body: some View {
            VStack {
                List {
                    ForEach(0..<userData.count, id: \.self) { index in
                        Text(userData[index])
                            .foregroundColor(.blue)
                    }
                }
            }
        .navigationTitle(user.name)
    }
    
}

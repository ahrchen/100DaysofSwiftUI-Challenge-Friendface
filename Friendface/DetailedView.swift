//
//  DetailedView.swift
//  Friendface
//
//  Created by Raymond Chen on 3/16/22.
//

import SwiftUI

struct DetailedView: View {
    let user: User
    let users: [User]
    
    var body: some View {
        ScrollView {
            Text(user.isActive ? "Active" : "Inactive")
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            Text("About")
                .padding()
                .font(.title)
            Text(user.about)
                .padding()

            Text("Friends")
                .font(.title)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            ForEach(user.friends) { friend in
                NavigationLink(destination: DetailedView(user: getUser(userId: friend.id), users: users)) {
                    VStack {
                        Text(friend.name)
                        Divider()
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: -27, trailing: 0))
                }
            }
            .padding()
        }
        .navigationTitle(user.name)
    }
    
    private func getUser(userId: UUID) -> User {
        users.first { (User) -> Bool in
            User.id == userId
        }!
    }
    
}


//
//  ContentView.swift
//  Friendface
//
//  Created by Raymond Chen on 3/16/22.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors:[]) var cachedUsers: FetchedResults<CachedUser>
    @FetchRequest(sortDescriptors:[]) var cachedFriends: FetchedResults<CachedFriend>
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users) { user in
                    NavigationLink(destination: DetailedView(user: user, users: users)) {
                        HStack {
                            Text(user.name)
                                .foregroundColor(.primary)
                            Text(user.isActive ? "Active" : "Inactive")
                                .foregroundColor(.secondary)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                }
            }
            .navigationTitle("Users")
        }
            .task {
                await loadData()

            }
    }
    
    func loadData() async {
        guard let url = URL(string:"https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }

        do  {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let decodedResponse = try? decoder.decode([User].self, from: data) {
                self.users = decodedResponse
            }
            await MainActor.run {
                saveData()

            }

        } catch {
            print("Invalid data, Using Stored Data")
            loadFromCache()
        }
    }
    
    func loadFromCache() {
        for cachedUser in cachedUsers {
            self.users.append(cachedUser.user)
        }
    }
    
    func saveData() {
        for user in users {
            let newUser = CachedUser(context: moc)
            newUser.id = user.id
            newUser.name = user.name
            newUser.isActive = user.isActive
            newUser.age = Int16(user.age)
            newUser.company = user.company
            newUser.email = user.email
            newUser.address = user.address
            newUser.about = user.about
            newUser.registered = user.registered
            newUser.tags = user.tags.joined(separator: ",")
            var friendArray: [CachedFriend] = []
            for friend in user.friends {
                let newCachedFriend = CachedFriend(context: moc)
                newCachedFriend.id = friend.id
                newCachedFriend.name = friend.name
                friendArray.append(newCachedFriend)
            }
            newUser.friends = Set(friendArray) as NSSet
        }
        if moc.hasChanges {
            try? moc.save()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  Friendface
//
//  Created by Raymond Chen on 3/16/22.
//

import SwiftUI

struct ContentView: View {
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
        } catch {
            print("Invalid data")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

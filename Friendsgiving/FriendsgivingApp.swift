//
//  FriendsgivingApp.swift
//  Friendsgiving
//
//  Created by Aimee Hong on 11/11/24.
//

import SwiftUI
import SwiftData

@main
struct FriendsgivingApp: App {
    var body: some Scene {
        WindowGroup {
            GuestListView()
                .modelContainer(for: Guest.self)
        }
    }
    
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}

//
//  Guest.swift
//  Friendsgiving
//
//  Created by Aimee Hong on 11/11/24.
//

import Foundation
import SwiftData

@Model
@MainActor
class Guest {
    var name: String
    var item: String
    var notes: String
    
    init(name: String, item: String, notes: String = "") {
        self.name = name
        self.item = item
        self.notes = notes
    }
    
    convenience init() {
        self.init(name: "", item: "")
    }
}

extension Guest {
    static var preview: ModelContainer {
        let container = try! ModelContainer(for: Guest.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        Task { @MainActor in
            container.mainContext.insert(Guest(name: "Aimee", item: "Ramen", notes: "Arriving with David"))
            container.mainContext.insert(Guest(name: "David", item: "Steak", notes: "Driver"))
            container.mainContext.insert(Guest(name: "Donut", item: "Donut Holes", notes: "Arriving with Aimee"))
            container.mainContext.insert(Guest(name: "Mochi", item: "Mochi Donuts", notes: "Arriving with David"))
        }
        
        return container
    }
}

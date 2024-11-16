//
//  GuestDetailView.swift
//  Friendsgiving
//
//  Created by Aimee Hong on 11/15/24.
//

import SwiftUI

struct GuestDetailView: View {
    @State var guest: Guest
    @State private var name = ""
    @State private var item = ""
    @State private var notes = ""
    @State private var selectedCategory: String? = nil
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Name", text: $name)
                .textFieldStyle(.roundedBorder)
                .font(.title)
                .padding(.vertical)
            
            Text("Is bringing: ")
                .bold()
            
            HStack {
                TextField("Item", text: $item)
                    .textFieldStyle(.roundedBorder)
                
                Text("Item Type: ")
                    .bold()
                
                Picker("", selection: $selectedCategory) {
                    Text("N/A").tag(nil as String?)
                    ForEach(Category.allCases, id: \.self) { category in
                        Text(category.rawValue.capitalized)
                            .tag(category.rawValue as String?)
                    }
                }
            }

            Text("Notes: ")
                .bold()
            
            TextField("Notes", text: $notes)
                .textFieldStyle(.roundedBorder)
            
            Spacer()

        }
        .padding(.horizontal)
        .onAppear() {
            name = guest.name
            item = guest.item
            notes = guest.notes
            selectedCategory = guest.itemCategory
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    guest.name = name
                    guest.item = item
                    guest.notes = notes
                    guest.itemCategory = selectedCategory
                    modelContext.insert(guest)
                    guard let _ = try? modelContext.save() else {
                        print("😡 ERROR: Save on GuestDetailView did not work.")
                        return
                    }
                    dismiss()
                }
            }
        }
    }
    
    enum Category: String, Codable, CaseIterable {
        case entree, side, dessert, beverage
    }
}

#Preview {
    NavigationStack {
        GuestDetailView(guest: Guest(name: "Lady Gaga", item: "Pokerface Punch", notes: "Non-alcoholic"))
            .modelContainer(for: Guest.self, inMemory: true)
    }
}

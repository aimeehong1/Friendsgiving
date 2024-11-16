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
            
            TextField("Item", text: $item)
                .textFieldStyle(.roundedBorder)

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
}

#Preview {
    NavigationStack {
        GuestDetailView(guest: Guest(name: "Lady Gaga", item: "Pokerface Punch", notes: "Non-alcoholic"))
            .modelContainer(for: Guest.self, inMemory: true)
    }
}

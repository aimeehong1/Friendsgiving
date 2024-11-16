//
//  ContentView.swift
//  Friendsgiving
//
//  Created by Aimee Hong on 11/11/24.
//

import SwiftUI
import SwiftData
import AVFAudio

struct GuestListView: View {
    @Query var guests: [Guest]
    @State private var sheetIsPresented = false
    @Environment(\.modelContext) var modelContext
    @State private var audioPlayer: AVAudioPlayer!
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(guests) { guest in
                        NavigationLink {
                            GuestDetailView(guest: guest)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(guest.name)
                                    .font(.title2)
                                    .bold()
                                Text("Bringing: \(guest.item)")
                                    .font(.title3)
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Friends: ")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            sheetIsPresented.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                        
                    }
                }
                .sheet(isPresented: $sheetIsPresented) {
                    NavigationStack {
                        GuestDetailView(guest: Guest(name: "", item: "", notes: ""))
                    }
                }
                .onAppear() {
                    playSound(soundName: "gobble")
                }
                
                Image("turkey")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.10)
            }
        }
    }
    
    func playSound(soundName: String) {
        guard let soundFile = NSDataAsset(name: soundName) else {
            print("😡 Could not read file named \(soundName)")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch {
            print("😡 ERROR: \(error.localizedDescription) creating audioPlayer")
        }
    }
}

#Preview {
    GuestListView()
        .modelContainer(Guest.preview)
}

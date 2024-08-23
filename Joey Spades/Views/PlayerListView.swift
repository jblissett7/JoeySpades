//
//  PlayerListView.swift
//  CharliesSpades
//
//  Created by Jordan Blissett on 8/20/24.
//

import SwiftUI

struct PlayerListView: View {
    @ObservedObject var game: Game
    @State private var newPlayerName = ""
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(spacing: 20){
            Text("Manage Players")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 40)
            HStack {
                TextField("Enter player name", text: $newPlayerName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .focused($isFocused)
                    .autocorrectionDisabled(true)
                    .onSubmit {
                        addPlayer()
                        isFocused = true
                    }
                Button(action: {
                    addPlayer()
                    isFocused = true
                }) {
                    Text("Add Player")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            List {
                ForEach(game.players) { player in
                    Text(player.name)
                        .font(.title3)
                }
                .onDelete { indexSet in
                    indexSet.forEach { game.removePlayer(at: $0) }
                }
            }
            .listStyle(InsetGroupedListStyle())
            Spacer()
            NavigationLink(destination: BidInputView(game: game)) {
                Text("Play")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 20)
        }
        .onTapGesture {
            isFocused = false
        }
        .navigationBarBackButtonHidden(true)
    }
    private func addPlayer() {
            if !newPlayerName.isEmpty {
                game.addPlayer(name: newPlayerName)
                newPlayerName = "" // Clear the text field after adding the player
            }
        }
}


#Preview {
    let sampleGame = Game()
    sampleGame.addPlayer(name: "Jordan")
    sampleGame.addPlayer(name: "Franki")
    return PlayerListView(game: sampleGame)
}

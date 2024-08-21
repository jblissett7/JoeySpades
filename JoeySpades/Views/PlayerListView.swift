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

    var body: some View {
        VStack {
            HStack {
                TextField("Enter player name", text: $newPlayerName)
                Button("Add Player") {
                    if !newPlayerName.isEmpty {
                        game.addPlayer(name: newPlayerName)
                        newPlayerName = ""
                    }
                }
            }
            List {
                ForEach(game.players) { player in
                    Text(player.name)
                }
                .onDelete { indexSet in
                    indexSet.forEach { game.removePlayer(at: $0) }
                }
            }
            NavigationLink("Play", destination: BidInputView(game: game))
                .padding()
        }
        .padding()
        .navigationTitle("Player Management")
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    let sampleGame = Game()
    sampleGame.addPlayer(name: "Jordan")
    sampleGame.addPlayer(name: "Franki")
    return PlayerListView(game: sampleGame)
}

//
//  ContentView.swift
//  CharliesSpades
//
//  Created by Jordan Blissett on 6/3/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var game = Game()

    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink("Manage Players", destination: PlayerListView(game: game))
                if game.players.isEmpty{
                    NavigationLink("Start Game", destination: BidInputView(game: game))
                } else {
                    NavigationLink("Resume Game", destination: BidInputView(game: game))
                }
                NavigationLink("Scoreboard", destination: ScoreboardView(game: game))
            }
            Button("Restart Game"){
                game.resetGame()
            }
            .navigationTitle("Joey Spades")
            .padding()
            .navigationBarBackButtonHidden(true)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//Array(repeating: Player(name: "", points: 0, bid: 0, tricksCaught: 0), count: 4)

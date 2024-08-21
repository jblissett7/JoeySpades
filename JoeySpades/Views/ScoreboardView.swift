//
//  ScoreboardView.swift
//  CharliesSpades
//
//  Created by Jordan Blissett on 8/20/24.
//

import SwiftUI


struct ScoreboardView: View {
    @ObservedObject var game: Game

    var body: some View {
        VStack {
            Text("Current Scores")
                .font(.largeTitle)
                .padding()

            List(game.players) { player in
                VStack(alignment: .leading) {
                    Text(player.name)
                        .font(.headline)
                    Text("Score: \(player.totalScore)")
                }
            }

            Button("Start Next Round") {
                game.nextRound()
            }
            .padding()
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationBarBackButtonHidden(true) // Prevent going back to the previous screen
    }
}

#Preview {
    let game = Game()
    game.players = [Player(name: "Alice"), Player(name: "Bob")]
    return ScoreboardView(game: game)
}

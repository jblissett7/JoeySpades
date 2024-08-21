//
//  RoundSummaryView.swift
//  CharliesSpades
//
//  Created by Jordan Blissett on 8/20/24.
//

import SwiftUI

struct RoundSummaryView: View {
    @ObservedObject var game: Game
    @State private var navigateToBidInputView = false

    var body: some View {
        VStack {
            Text("Round \(game.currentRound) Summary")
                .font(.largeTitle)
                .padding()

            List(game.players) { player in
                VStack(alignment: .leading) {
                    Text(player.name).font(.headline)
                    Text("Total Score: \(player.totalScore)")
                }
            }

            NavigationLink(destination: BidInputView(game: game), isActive: $navigateToBidInputView) {
                            Button("Start Next Round") {
                                game.nextRound()
                                navigateToBidInputView = true // Trigger navigation
                            }
                            .padding()
                            .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .padding()
        .onAppear(){
            game.calculateScores()
        }
        .navigationBarBackButtonHidden(true)
    }
//    private func navigateToBidInputView() {
//            DispatchQueue.main.async {
//                self.presentationMode.wrappedValue.dismiss()
//            }
//        }
}

#Preview {
    let sampleGame = Game()
    sampleGame.addPlayer(name: "Jordan")
    return RoundSummaryView(game: sampleGame)
}

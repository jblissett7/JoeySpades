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
    @State private var navigateToHomeView = false
    @State private var sortedPlayers: [Player] = []

    var body: some View {
        
        VStack(spacing: 20) {
            Text("Round \(game.currentRound) Summary")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 40)

            List(sortedPlayers) { player in
                VStack(alignment: .leading) {
                    Text(player.name).font(.headline)
                    Text("Total Score: \(player.totalScore)")
                }
            }
            .listStyle(InsetGroupedListStyle())

            if game.currentRound == game.totalRounds {
                Button(action: {
                    navigateToHomeView = true
                }){
                    Text("Finish Game")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                        .padding(.bottom, 20)
                }
                .navigationDestination(isPresented: $navigateToHomeView) {
                    ContentView()
                }
            } else {
                Button(action: {
                    game.nextRound()
                    navigateToBidInputView = true // Trigger navigation
                }){
                    Text("Start Next Round")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                        .padding(.bottom, 20)
                }
                .navigationDestination(isPresented: $navigateToBidInputView) {
                    BidInputView(game: game)
                }
            }
        }
        .padding()
        .onAppear(){
            game.calculateScores()
            sortedPlayers = game.players.sorted(by: { $0.totalScore < $1.totalScore })
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    let sampleGame = Game()
    sampleGame.addPlayer(name: "Jordan")
    sampleGame.addPlayer(name: "Franki")
    sampleGame.addPlayer(name: "Mom")
    sampleGame.addPlayer(name: "Dad")
    sampleGame.addPlayer(name: "Addi")
    sampleGame.addPlayer(name: "Jack")
    sampleGame.addPlayer(name: "Tessa")
    sampleGame.addPlayer(name: "Cam")
    return RoundSummaryView(game: sampleGame)
}

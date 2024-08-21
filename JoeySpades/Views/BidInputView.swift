//
//  bidInputView.swift
//  CharliesSpades
//
//  Created by Jordan Blissett on 8/20/24.
//

import SwiftUI

struct BidInputView: View {
    @ObservedObject var game: Game
    @State private var navigateToHome = false

    var body: some View {
        VStack {
            Text("Round \(game.currentRound)")
            Text("Round Value: \(game.roundValue)")
            Text("Dealer: \(game.players[game.dealerIndex].name)")
            Text("Number of Cards: \(game.numberOfCards)")

            ForEach(game.players.indices, id: \.self) { index in
                HStack {
                    Text(game.players[index].name)
                        .bold()
                        .foregroundColor(index == game.roundLeadIndex ? .green : .black)
                    Spacer()
                    TextField("Enter bid", value: Binding(
                        get: {
                            game.players[index].bid
                        },
                        set: { newValue in
                            game.updateBid(for: game.players[index], with: newValue)
                        }
                    ), formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
            }

            NavigationLink("Play", destination: TrickCountInputView(game: game))
                .padding()
            NavigationLink(destination: ContentView(), isActive: $navigateToHome) {
                           Button("Go Home") {
                               navigateToHome = true
                           }
                           .padding()
                           .buttonStyle(.bordered)
                       }
        }
        .padding()
        .navigationTitle("Enter Bids")
        .navigationBarBackButtonHidden(true)
    }
    
}

//
//  TrickCountInputView.swift
//  CharliesSpades
//
//  Created by Jordan Blissett on 8/20/24.
//

import SwiftUI

struct TrickCountInputView: View {
    @ObservedObject var game: Game
    @State private var showAlert = false
    @State private var showRoundSummary = false

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
                    VStack(alignment: .trailing) {
                        Text("Bid: \(game.players[index].bid)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        TextField("Enter tricks caught", value: Binding(
                            get: {
                                game.players[index].tricksCaught
                            },
                            set: { newValue in
                                game.updateTricksCaught(for: game.players[index], with: newValue)
                            }
                        ), formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 60)
                    }
                }
            }
                
            Button("Show Scores"){
                if game.validateTotalTricks(){
                    showRoundSummary = true
                } else {
                    showAlert = true
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Invalid Input"), message: Text("Total Tricks caught must equal the number of cards dealt"), dismissButton: .default(Text("OK")))
            }
            .padding()
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationDestination(isPresented: $showRoundSummary){
            RoundSummaryView(game: game)
        }
        .navigationTitle("Tricks Caught")
    }
}

#Preview {
    let sampleGame = Game()
    sampleGame.addPlayer(name: "Jordan")
    sampleGame.addPlayer(name: "Franki")
    return TrickCountInputView(game: sampleGame)
}

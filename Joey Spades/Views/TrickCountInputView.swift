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
    @FocusState private var isFocused: Bool

    var body: some View {
        let reorderedPlayers = reorderedPlayerList()
        NavigationStack{
            VStack(spacing: 10) {
                Text("Round \(game.currentRound)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                Text("Round Value: \(game.roundValue)")
                    .font(.title2)
                
                Text("Dealer: \(game.players[game.dealerIndex].name)")
                    .font(.title2)
                
                Text("Number of Cards: \(game.numberOfCards)")
                    .font(.title3)
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 20)
            
            ScrollView{
                VStack(spacing: 10){
                    ForEach(reorderedPlayers.indices, id: \.self) { index in
                        HStack {
                            Text(reorderedPlayers[index].name)
                                .font(.title3)
                                .bold()
//                                .foregroundColor(index == game.roundLeadIndex ? .green : .black)
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("Bid: \(reorderedPlayers[index].bid)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                TextField("Enter tricks caught", text: Binding(
                                    get: {
                                        reorderedPlayers[index].tricksCaught == 0 ? "" :
                                        String(reorderedPlayers[index].tricksCaught)
                                    },
                                    set: { newValue in
                                        if let intValue = Int(newValue) {
                                            game.updateTricksCaught(for: reorderedPlayers[index], with: intValue)
                                        } else {
                                            game.updateTricksCaught(for: reorderedPlayers[index], with: 0)
                                        }
                                    }
                                ))
                                .keyboardType(.numberPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 80)
                                .focused($isFocused)
                                .onTapGesture {
                                    if reorderedPlayers[index].tricksCaught == 0 {
                                        game.updateTricksCaught(for: reorderedPlayers[index], with: 0)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.horizontal, 30)
            .frame(maxHeight: .infinity)
            
            VStack(spacing: 10){
                Button(action:{
                    if game.validateTotalTricks(){
                        showRoundSummary = true
                    } else {
                        showAlert = true
                    }
                }){
                    Text("Show Scores")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 20)
                    .padding(.top, 10)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Invalid Input"), message: Text("Total Tricks caught must equal the number of cards dealt"), dismissButton: .default(Text("OK")))
                    }
                    .navigationDestination(isPresented: $showRoundSummary){
                        RoundSummaryView(game: game)
                    }
                }
                
            }
        }
        .onTapGesture {
            isFocused = false
        }
    }
    func reorderedPlayerList() -> [Player] {
        let roundLeadIndex = game.roundLeadIndex
        let players = game.players

        // Start with the round leader, then append the rest of the players
        let leadingPlayers = players[roundLeadIndex..<players.count]
        let trailingPlayers = players[0..<roundLeadIndex]
            
        return Array(leadingPlayers) + Array(trailingPlayers)
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
    return TrickCountInputView(game: sampleGame)
}

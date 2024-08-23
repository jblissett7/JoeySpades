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
    @State private var navigateToTrickCount = false
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
                //                    .padding(.bottom, 10)
                Text("Number of Cards: \(game.numberOfCards)")
                    .font(.title3)
                    .foregroundColor(.gray)
                    .padding(.bottom, 20)
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
                            // Temporary String Binding
                            TextField("Enter bid", text: Binding(
                                get: {
                                    reorderedPlayers[index].bid == 0 ? "" : String(reorderedPlayers[index].bid)
                                },
                                set: { newValue in
                                    if let intValue = Int(newValue) {
                                        game.updateBid(for: reorderedPlayers[index], with: intValue)
                                    } else {
                                        game.updateBid(for: reorderedPlayers[index], with: 0)
                                    }
                                }
                            ))
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 80)
                            .focused($isFocused)
                            .onTapGesture {
                                if reorderedPlayers[index].bid == 0 {
                                    game.updateBid(for: reorderedPlayers[index], with: 0)
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
                Button(action: {
                    navigateToTrickCount = true
                    isFocused = false
                }) {
                    Text("Play")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                }
                
                
                Button(action: {
                    navigateToHome = true
                    isFocused = false
                }){
                    Text("Home")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 20)
                    .padding(.top, 10)
                }
                
            }
//            .background(
//                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.white]),
//                               startPoint: .top, endPoint: .bottom)
//            )
            .navigationDestination(isPresented: $navigateToTrickCount) {
                TrickCountInputView(game: game)
            }
            .navigationDestination(isPresented: $navigateToHome) {
                ContentView()
            }
            .navigationBarBackButtonHidden(true)
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
    return BidInputView(game: sampleGame)
}

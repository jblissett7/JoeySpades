//
//  GameView.swift
//  CharliesSpades
//
//  Created by Jordan Blissett on 6/4/23.
//

import SwiftUI

struct GameView: View {
    @Binding var players: [Player]
    let cardsPerPlayer: Int
    let round: Int
    
    @State var bid: [String] = ["0"]
    @State private var currentTurn: Int = 0
    var body: some View {
        VStack {
            Text("Round: \(round)")
            Text("Current Turn: \(players[currentTurn].name)")
            
            ForEach(players.indices, id: \.self) { index in
                let player = $players[index]

                VStack {
                    Text("Player \(index + 1)")

                    Picker("Select Number of Cards", selection: player.bid) {
                        ForEach(0...cardsPerPlayer, id: \.self) { number in
                            Text("\(number)")
                        }
                    }
                    .pickerStyle(.wheel)
                }
            }

            

            // Allow player to enter their bid
//            Stepper(value: $bids[currentTurn], in: 0...cardsPerPlayer, step: 1) {
//                Text("Enter Bid: \(bids[currentTurn])")
//            }

            // Button to navigate to the next player's turn
//            Button(action: {
//                for _ in 0..<currentTurn{
//
//                }
//                if let bidvalue = Int(bid){
//                    player.bid = bidvalue
//                }
//            }) {
//                Text("Next Player")
//            }
        }
    }
//    func nextPlayerTurn(){
//        currentTurn += 1
//        
//        if currentTurn >= players.count{
//            print("Calculating Score and moving to next round")
//        }
//    }
}



struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(players: .constant([Player(id: UUID(), name: "Jordan", points: 0, bid: 0, tricksCaught: 0)]), cardsPerPlayer: 5, round: 1)
    }
}

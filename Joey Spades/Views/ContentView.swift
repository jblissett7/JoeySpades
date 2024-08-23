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
            VStack(spacing: 20) {
                Text("Joey Spades")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 40)
                
                VStack(spacing: 15){
                    NavigationLink(destination: PlayerListView(game: game)){
                        Label("Manage Players", systemImage: "person.3.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    NavigationLink(destination: BidInputView(game: game)){
                        Label("Start Game", systemImage: "play.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(10)
                                
                    }
                    NavigationLink(destination: ScoreboardView(game: game)) {
                        Label("Scoreboard", systemImage: "list.bullet")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.purple)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 30)
                Spacer()
                Button(action: {
                    game.resetGame()
                }) {
                    Text("Restart Game")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 30)
                .padding(.bottom,20)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

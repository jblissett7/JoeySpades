//
//  GameData.swift
//  CharliesSpades
//
//  Created by Jordan Blissett on 6/13/23.
//

import SwiftUI

class Game: ObservableObject {
    @Published var players: [Player] = [] {
        didSet{
            setupNewGame()
        }
    }
    @Published var currentRound: Int = 1
    @Published var roundValue: Int = 0
    @Published var dealerIndex: Int = 0
    @Published var roundLeadIndex: Int = 1
    @Published var numberOfCards: Int = 0
    @Published var totalRounds: Int = 0
    
    init() {
//            setupNewGame()
        }

    func setupNewGame() {
        // Reset game properties to start a new game
        currentRound = 1
        numberOfCards = calculateStartingNumberOfCards()
        roundValue = players.count
        totalRounds = 2 * numberOfCards
        for player in players {
            player.totalScore = 0
            player.bid = 0
            player.tricksCaught = 0
        }
    }
    
    func resetGame(){
        setupNewGame()
    }
    
    func calculateStartingNumberOfCards() -> Int {
            // Calculate the starting number of cards
        if players.count == 0{
            return 0;
        }
            return 52 / players.count
        }

    private var initialNumberOfCards: Int {
        if players.count == 0 {
            return 0
        }
        return max(1, 52 / players.count)
    }
    
//    private var totalRounds: Int {
//        let numCards = initialNumberOfCards
//        return (numCards - 1) * 2 + 1
//    }

    func addPlayer(name: String) {
        players.append(Player(name: name))
        updateRoundValue()
        updateNumberOfCards()
    }

    func removePlayer(at index: Int) {
        players.remove(at: index)
        updateRoundValue()
        updateNumberOfCards()
    }

    func nextRound() {
        currentRound += 1
//        if currentRound > totalRounds {
//            currentRound = 1
//        }
        dealerIndex = (dealerIndex + 1) % players.count
        roundLeadIndex = (roundLeadIndex + 1) % players.count
        updateRoundValue()
        updateNumberOfCards()
        resetBidsAndTricks()
    }

    private func updateRoundValue() {
        roundValue = players.count + currentRound - 1
    }

    private func updateNumberOfCards() {
        let numCards = initialNumberOfCards
        let midpoint = numCards  // This is the round where we reach 1 card

        if currentRound < midpoint {
            // Decreasing phase
            numberOfCards = numCards - currentRound
        } else if currentRound == midpoint {
            // The first round with 1 card
            numberOfCards = 1
        } else {
            // Increasing phase (starting from the round after the first 1 card round)
            numberOfCards = currentRound - midpoint + 1
        }
    }

    func calculateScores() {
        for player in players {
            let delta = abs(player.bid - player.tricksCaught)
            let roundScore = delta * roundValue
            player.totalScore += roundScore
        }
    }

    private func resetBidsAndTricks() {
        for player in players {
            player.bid = 0
            player.tricksCaught = 0
        }
    }

    func updateBid(for player: Player, with bid: Int) {
        if let index = players.firstIndex(where: { $0.id == player.id }) {
            players[index].bid = bid
        }
    }

    func updateTricksCaught(for player: Player, with tricks: Int) {
        if let index = players.firstIndex(where: { $0.id == player.id }) {
            players[index].tricksCaught = tricks
        }
    }
    
    func validateTotalTricks() -> Bool {
        let totalTricksCaught = players.reduce(0) { $0 + $1.tricksCaught }
        return totalTricksCaught == numberOfCards
    }
}


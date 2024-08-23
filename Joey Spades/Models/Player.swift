//
//  Player.swift
//  CharliesSpades
//
//  Created by Jordan Blissett on 6/3/23.
//

import SwiftUI

class Player: Identifiable {
    let id = UUID()
    var name: String
    var bid: Int = 0  // Only store bid for the current round
    var tricksCaught: Int = 0  // Only store tricks caught for the current round
    var totalScore: Int = 0

    init(name: String) {
        self.name = name
    }
}


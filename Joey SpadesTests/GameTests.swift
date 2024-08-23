//
//  GameTests.swift
//  JoeySpadesTests
//
//  Created by Jordan Blissett on 8/22/24.
//

import XCTest
@testable import Joey_Spades

final class GameTests: XCTestCase {
    
    var game: Game!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        game = Game()
        game.addPlayer(name: "Jordan")
        game.addPlayer(name: "Franki")
        game.addPlayer(name: "Mom")
        game.addPlayer(name: "Dad")
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        game = nil
    }
    
    func testCalculateScores(){
        // Arrange
        game.players[0].bid = 2
        game.players[0].tricksCaught = 3
        game.players[1].bid = 1
        game.players[1].tricksCaught = 1
        game.players[2].bid = 2
        game.players[2].tricksCaught = 2
        
        // Act
        game.calculateScores()
        
        // Assert
        XCTAssertEqual(game.players[0].totalScore, 1 * game.roundValue)
        XCTAssertEqual(game.players[1].totalScore, 0 * game.roundValue)
        XCTAssertEqual(game.players[2].totalScore, 0 * game.roundValue)
    }
    
    func testReorderPlayersForBidInputView() {
        // Arrange
        game.roundLeadIndex = 1  // Franki is the round leader
        
        // Act
        let reorderedPlayers = reorderedPlayerList()
        
        // Assert
        XCTAssertEqual(reorderedPlayers[0].name, "Franki")
        XCTAssertEqual(reorderedPlayers[1].name, "Mom")
        XCTAssertEqual(reorderedPlayers[2].name, "Dad")
        XCTAssertEqual(reorderedPlayers[3].name, "Jordan")
    }
    
    func testReorderPlayersForRoundSummaryView() {
        // Arrange
        game.players[0].totalScore = 10
        game.players[1].totalScore = 5
        game.players[2].totalScore = 15
        game.players[3].totalScore = 7
        
        // Act
        let sortedPlayers = game.players.sorted(by: { $0.totalScore < $1.totalScore })
        
        // Assert
        XCTAssertEqual(sortedPlayers[0].name, "Franki")   // Bob has the lowest score
        XCTAssertEqual(sortedPlayers[1].name, "Dad")
        XCTAssertEqual(sortedPlayers[2].name, "Jordan")   // Dan has the highest score
        XCTAssertEqual(sortedPlayers[3].name, "Mom")
    }
    
    // Helper function to simulate the reordering used in BidInputView
    func reorderedPlayerList() -> [Player] {
        let roundLeadIndex = game.roundLeadIndex
        let players = game.players
        
        let leadingPlayers = players[roundLeadIndex..<players.count]
        let trailingPlayers = players[0..<roundLeadIndex]
        
        return Array(leadingPlayers) + Array(trailingPlayers)
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

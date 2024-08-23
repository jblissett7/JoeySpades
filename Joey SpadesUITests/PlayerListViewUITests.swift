//
//  PlayerListViewUITests.swift
//  Joey SpadesUITests
//
//  Created by Jordan Blissett on 8/22/24.
//

import XCTest

class PlayerListViewUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Stop immediately when a failure occurs
        continueAfterFailure = false

        // Launch the application
        app = XCUIApplication()
        app.launch()
        let managePlayersButton = app.buttons["Manage Players"]
        managePlayersButton.tap()
    }

    override func tearDownWithError() throws {
        // Clean up after each test
        app = nil
    }

    func testAddPlayer() throws {
        // Test to add a new player
        let playerNameField = app.textFields["Enter player name"]
        XCTAssertTrue(playerNameField.waitForExistence(timeout: 5), "Player Name Field not found")
        let addPlayerButton = app.buttons["Add Player"]

        // Add a player named "Jordan"
        playerNameField.tap()
        playerNameField.typeText("Jordan")
        addPlayerButton.tap()

        // Assert the player "Jordan" was added to the list
        XCTAssert(app.staticTexts["Jordan"].exists)
    }

//    func testRemovePlayer() throws {
//        // Test to remove a player from the list
//        let playerNameField = app.textFields["Enter player name"]
//        let addPlayerButton = app.buttons["Add Player"]
//
//        // Add a player named "Jordan"
//        playerNameField.tap()
//        playerNameField.typeText("Jordan")
//        addPlayerButton.tap()
//
//        // Swipe to delete the player
//        let player = app.staticTexts["Jordan"]
//        player.swipeLeft()
//        player.swipeLeft()
////        app.buttons["Delete"].tap()
//
//        // Assert the player "Jordan" was removed from the list
//        XCTAssertFalse(app.staticTexts["Jordan"].exists)
//    }

    func testPlayerListNavigation() throws {
        // Test to navigate to the bid input screen
        let playerNameField = app.textFields["Enter player name"]
        let addPlayerButton = app.buttons["Add Player"]
        let playButton = app.buttons["Play"]

        // Add players
        playerNameField.tap()
        playerNameField.typeText("Jordan")
        addPlayerButton.tap()

        
        playerNameField.typeText("Franki")
        addPlayerButton.tap()

        // Tap on the "Play" button to navigate to the next screen
        playButton.tap()

        // Assert that the next screen is displayed
        XCTAssert(app.staticTexts["Round 1"].exists)
    }
}


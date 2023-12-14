//
//  CharacterUITests.swift
//  Marvel AppUITests
//
//  Created by Rodrigo Amora on 14/12/23.
//

import XCTest

class CharacterUITests: XCTestCase {
    
    // MARK: - Atributes
    var app: XCUIApplication!

    // MARK: - setUp
    override func setUp() {
        continueAfterFailure = false
        self.app = XCUIApplication()
        self.app.launchArguments = ["testing"]
        self.app.launch()
    }
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {}
    
    // MARK: - Tests
    func testVerifiyNameAndDescriptionOfCharacterAfterSelectOneCharacter() throws {
        let characterTableView = self.app.tables
        characterTableView.cells.element(boundBy: 0).firstMatch.tap()
        
        let nameCharacterLabel = self.app.staticTexts["nameCharacter"]
        let descriptionCharacterLabel = self.app.staticTexts["descriptionCharacter"]
        
        XCTAssertEqual("3-D Man", nameCharacterLabel.label)
        XCTAssertNotNil(descriptionCharacterLabel.label)
    }
    
}

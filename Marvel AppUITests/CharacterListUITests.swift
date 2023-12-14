//
//  CharacterListUITests.swift
//  Marvel AppUITests
//
//  Created by Rodrigo Amora on 16/07/23.
//

import XCTest

final class CharacterListUITests: XCTestCase {
    
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

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    // MARK: - Tests
    func testVerifiyNameOfFirstCharacter() throws {
        let characterTableView = self.app.tables
        XCTAssertEqual("3-D Man", characterTableView.cells.element(boundBy: 0).staticTexts["nameCharacter"].label)
    }

    func testVerifiyNameAndDescriptionOfCharacterAfterSelectOneCharacter() throws {
        let characterTableView = self.app.tables
        characterTableView.cells.element(boundBy: 0).firstMatch.tap()
        
        let nameCharacterLabel = self.app.staticTexts["nameCharacter"]
        let descriptionCharacterLabel = self.app.staticTexts["descriptionCharacter"]
        
        XCTAssertEqual("3-D Man", nameCharacterLabel.label)
        XCTAssertNotNil(descriptionCharacterLabel.label)
    }
    
}

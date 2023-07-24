//
//  CharacterUITests.swift
//  Marvel AppUITests
//
//  Created by Rodrigo Amora on 16/07/23.
//

import XCTest

final class CharacterUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["testing"]
        app.launch()
    }
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {}

    func testVerifiyNameOfFirstCharacter() throws {
        let characterTableView = app.tables
        XCTAssertEqual("3-D Man", characterTableView.cells.element(boundBy: 0).staticTexts["nameCharacter"].label)
    }

    func testVerifiyNameAndDescriptionOfCharacterAfterSelectOneCharacter() throws {
        let characterTableView = app.tables
        characterTableView.cells.element(boundBy: 0).firstMatch.tap()
        
        let nameCharacterLabel = app.staticTexts["nameCharacter"]
        let descriptionCharacterLabel = app.staticTexts["descriptionCharacter"]
        
        XCTAssertEqual("3-D Man", nameCharacterLabel.label)
        XCTAssertNotNil(descriptionCharacterLabel.label)
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

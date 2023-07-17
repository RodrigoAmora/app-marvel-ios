//
//  CharacterUITests.swift
//  Marvel AppUITests
//
//  Created by Rodrigo Amora on 16/07/23.
//

import XCTest

final class CharacterUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testVerifiyNameOfFirstCharacter() throws {
        let app = XCUIApplication()
        app.launch()
        
        let characterTableView = app.tables
        
        XCTAssertEqual(20, characterTableView.cells.count)
        XCTAssertEqual("3-D Man", characterTableView.cells.element(boundBy: 0).staticTexts["nameCharacter"].label)
    }

    func testVerifiyNameAndDescriptionOfCharacterAfterSelectOneCharacter() throws {
        let app = XCUIApplication()
        app.launch()
        
        let characterTableView = app.tables
        characterTableView.cells.element(boundBy: 0).tap()
        
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

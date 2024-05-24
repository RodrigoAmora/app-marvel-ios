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
    
    // MARK: - Tests
    func testVerifiyNameOfFirstCharacter() throws {
        let characterTableView = self.app.tables
        XCTAssertEqual("3-D Man", characterTableView.cells.element(boundBy: 0).staticTexts["nameCharacter"].label)
    }
    
    func testSearchCharacter() throws {
        let characterTableView = self.app.tables
        XCTAssertEqual("3-D Man", characterTableView.cells.element(boundBy: 0).staticTexts["nameCharacter"].label)
//        self.app.tables["characterTableView"]//.element
        
        self.app.buttons["fabSearchBar"].tap()
        
        let characterByNameSearchView = self.app.otherElements["characterByNameSearchBar"]
        characterByNameSearchView.tap()
        characterByNameSearchView.typeText("Hulk")
        
        
        self.app.keyboards.buttons["Search"].tap()
//        self.app.keys.buttons[XCUIKeyboardKey.enter.rawValue].tap()
//        self.app.keyPressure("iOSGO")
        
        let expectation = XCTestExpectation(description: "Your expectation")
        let timeInSeconds = 7.0
        DispatchQueue.main.asyncAfter(deadline: .now() + timeInSeconds) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeInSeconds + 1.0)
        
        XCTAssertEqual("Hulk", characterTableView.cells.element(boundBy: 0).staticTexts["nameCharacter"].label)
    }
    
}

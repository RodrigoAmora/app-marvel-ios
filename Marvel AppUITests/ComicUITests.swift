//
//  ComicUITests.swift
//  Marvel AppUITests
//
//  Created by Rodrigo Amora on 10/12/23.
//

import Foundation
import XCTest

final class ComicUITests: XCTestCase {
    
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
    
    // MARK: - Tests
    func testVerifiyNameOfComicIsCorrect() throws {
        let characterTableView = self.app.tables
        characterTableView.cells.element(boundBy: 1).firstMatch.tap()
        
        let nameCharacterLabel = self.app.staticTexts["nameCharacter"]
        let descriptionCharacterLabel = self.app.staticTexts["descriptionCharacter"]
        
        XCTAssertEqual("A-Bomb (HAS)", nameCharacterLabel.label)
        XCTAssertNotNil(descriptionCharacterLabel.label)
        
        let timeInSeconds = 10.0
        let expectation = XCTestExpectation(description: "Your expectation")

        DispatchQueue.main.asyncAfter(deadline: .now() + timeInSeconds) {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: timeInSeconds + 1.0)

        let titleComic = "Hulk (2008) #53"
        let listComicsPicker = self.app.pickers["listComicsPicker"]
        listComicsPicker.pickerWheels.element.swipeUp()
        
        let nameComicLabel = self.app.staticTexts["nameComic"]
        XCTAssertEqual(titleComic, nameComicLabel.label)
    }
    
}

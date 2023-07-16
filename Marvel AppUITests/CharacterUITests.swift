//
//  CharacterUITests.swift
//  Marvel AppUITests
//
//  Created by Rodrigo Amora on 16/07/23.
//

import XCTest

final class CharacterUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testVerifiyNameOfFirstCharacter() throws {
        let app = XCUIApplication()
        app.launch()
        
        let characterTableView = app.tables
        let tableViewCell = characterTableView.cells["characterTableViewCell"]
        
        XCTAssertEqual(20, characterTableView.cells.count)
        XCTAssertEqual("3-D Man", characterTableView.cells.element(boundBy: 0).staticTexts["nameCharacter"].label)
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

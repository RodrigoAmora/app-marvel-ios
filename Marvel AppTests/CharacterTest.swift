//
//  CharacterTest.swift
//  Marvel AppTests
//
//  Created by Rodrigo Amora on 19/07/23.
//

import XCTest
@testable import Marvel_App

final class CharacterTest: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testExample() throws {}

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testVerifyURLFormated() {
        let thumbnail = Thumbnail(
            path: "http://i.annihil.us/u/prod/marvel/i/mg/3/50/537ba56d31087",
            extensionPhoto: "jpg"
        )
        
        let nameCaptainAmerica = "Capitain America"
        let descriptionCaptainAmerica = """
            Vowing to serve his country any way he could, young Steve Rogers took the super soldier
            serum to become America's one-man army.
            Fighting for the red, white and blue for over 60 years, Captain America is the living,
            breathing symbol of freedom and liberty.
            """
        
        let captainAmerica = Character(
            id: 1,
            name: nameCaptainAmerica,
            characterDescription: descriptionCaptainAmerica,
            thumbnail: thumbnail
        )
        
        let urlFormated = "http://i.annihil.us/u/prod/marvel/i/mg/3/50/537ba56d31087.jpg"
        
        XCTAssertEqual(urlFormated, captainAmerica.thumbnail?.formatURL())
    }
}

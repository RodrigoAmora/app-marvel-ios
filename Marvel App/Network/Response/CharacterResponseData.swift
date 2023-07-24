//
//  CharacterData.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 30/06/23.
//

import Foundation

class CharacterResponseData: Decodable {
    // MARK: - Atributes
    var total: Int = 0
    var results: [Character] = []
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case total
        case results = "results"
    }
}

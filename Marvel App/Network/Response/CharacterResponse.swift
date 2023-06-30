//
//  CharacterResponse.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 30/06/23.
//

import Foundation
//import ObjectMapper

struct CharacterResponse: Decodable {
    // MARK: - Atributes
    var code: Int = 0
    var data: CharacterData?
    var status: String = ""
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case code
        case data = "data"
        case status
    }
    
}

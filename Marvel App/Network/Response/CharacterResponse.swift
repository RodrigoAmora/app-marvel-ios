//
//  CharacterResponse.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 30/06/23.
//

import Foundation
//import ObjectMapper

class CharacterResponse: Decodable {
    // MARK: - Atributes
    var data: CharacterResponseData?
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        
        case data = "data"
        
    }
    
}

//
//  ComicResponse.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 10/07/23.
//

import Foundation

class ComicResponse: Decodable {
    // MARK: - Atributes
    var code: Int = 0
    var data: ComicData?
    var status: String = ""
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case code
        case data = "data"
        case status
    }
}

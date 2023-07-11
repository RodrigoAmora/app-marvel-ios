//
//  ComicData.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 10/07/23.
//

import Foundation

class ComicData: NSObject, Decodable {
    // MARK: - Atributes
    var total: Int = 0
    var results: [Comic] = []
}

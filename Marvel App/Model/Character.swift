//
//  Character.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 29/06/23.
//

import Foundation
import CoreData
import ObjectMapper

class Character: NSObject, Decodable {
    
    // MARK: - Atributes
    var id: Int = 0
    var name: String = ""
    var characterDescription: String = ""
    
    required init?(map: Map) {}
    
}

// MARK: Mappable
extension Character: Mappable {
    
    func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
        characterDescription    <- map["description"]
    }
    
}

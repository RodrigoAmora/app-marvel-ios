//
//  Character.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 29/06/23.
//

import Foundation
import CoreData

class Character: NSObject, NSCoding, Decodable {
    
    // MARK: - Atributes
    var id: Int = 0
    var name: String = ""
    var characterDescription: String = ""
    var thumbnail: Thumbnail?
    
    // MARK: - NSCoding
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(name, forKey: "name")
        coder.encode(characterDescription, forKey: "description")
        coder.encode(thumbnail, forKey: "thumbnail")
    }
    
    required init?(coder: NSCoder) {
        id = coder.decodeObject(forKey: "id") as! Int
        name = coder.decodeObject(forKey: "name") as! String
        characterDescription = coder.decodeObject(forKey: "description") as! String
        thumbnail = coder.decodeObject(forKey: "thumbnail") as! Thumbnail
    }
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case id
        case characterDescription = "description"
        case name
        case thumbnail
    }
    
}

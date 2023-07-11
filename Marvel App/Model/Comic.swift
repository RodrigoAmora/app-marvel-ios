//
//  Comic.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 10/07/23.
//

import Foundation

class Comic: NSObject, NSCoding, Decodable {
    
    // MARK: - Atributes
    var id: Int = 0
    var title: String = ""
    var comicDescription: String = ""
    var thumbnail: Thumbnail?
    
    // MARK: - Init
    init(id: Int, title: String, comicDescription: String, thumbnail: Thumbnail) {
        self.id = id
        self.title = title
        self.comicDescription = comicDescription
        self.thumbnail = thumbnail
    }
    
    // MARK: - NSCoding
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(title, forKey: "title")
        coder.encode(comicDescription, forKey: "description")
        coder.encode(thumbnail, forKey: "thumbnail")
    }
    
    required init?(coder: NSCoder) {
        id = coder.decodeInteger(forKey: "id") as! Int
        title = coder.decodeObject(forKey: "title") as! String
        comicDescription = coder.decodeObject(forKey: "description") as! String
        thumbnail = coder.decodeObject(forKey: "thumbnail") as! Thumbnail
    }
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case id
        case comicDescription = "description"
        case title
        case thumbnail
    }
    
}

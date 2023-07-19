//
//  Thumbnail.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 30/06/23.
//

import Foundation

class Thumbnail: NSObject, NSCoding, Decodable {
    
    // MARK: - Atributes
    var extensionPhoto: String
    var path: String
    
    // MARK: - Init
    init(path: String, extensionPhoto: String) {
        self.path = path
        self.extensionPhoto = extensionPhoto
    }
    
    // MARK: - NSCoding
    func encode(with coder: NSCoder) {
        coder.encode(extensionPhoto, forKey: "extensionPhoto")
        coder.encode(path, forKey: "path")
    }
    
    required init?(coder: NSCoder) {
        extensionPhoto = coder.decodeObject(forKey: "extensionPhoto") as! String
        path = coder.decodeObject(forKey: "path") as! String
    }
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case extensionPhoto = "extension"
        case path
    }
    
    func formatURL() -> String {
        return "\(path).\(extensionPhoto)"
    }
    
}

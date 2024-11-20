//
//  Thumbnail.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 30/06/23.
//

import Foundation
import UIKit
import CoreData

@objc(Thumbnail)
class Thumbnail: NSManagedObject, Decodable {
    
    // MARK: - Atributes
    @NSManaged var extensionPhoto: String
    @NSManaged var path: String
    
    /// MARK: - Init
    convenience init(path: String, extensionPhoto: String) {
        let contexto = UIApplication.shared.delegate as! AppDelegate
        self.init(context: contexto.persistentContainer.viewContext)
        self.path = path
        self.extensionPhoto = extensionPhoto
    }
    
    required convenience init(from decoder: Decoder) throws {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        self.init(context: managedContext)
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.path = try container.decode(String.self, forKey: .path)
            self.extensionPhoto = try container.decode(String.self, forKey: .extensionPhoto)
        } catch {
            print("Error retriving questions \(error)")
        }
    }
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case extensionPhoto = "extension"
        case path = "path"
    }
    
    // MARK: - Methods
    func formatURL() -> String {
        return "\(path).\(extensionPhoto)"
    }
    
    // MARK: - ManagedObjectError
    enum ManagedObjectError: Error {
        case decodeContextError
        case decodeEntityError
    }
}

//
//  Character.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 29/06/23.
//

import Foundation
import UIKit
import CoreData

@objc(Character)
class Character: NSManagedObject, Decodable {
    
    // MARK: - Atributes
    @NSManaged var id: Int64
    @NSManaged var name: String
    @NSManaged var characterDescription: String
    @NSManaged var thumbnail: Thumbnail?
    
    // MARK: - Inits
    convenience init(id: Int64, name: String, characterDescription: String, thumbnail: Thumbnail) {
        let managedContext = UIApplication.shared.delegate as! AppDelegate
        self.init(context: managedContext.persistentContainer.viewContext)
        self.id = id
        self.name = name
        self.characterDescription = characterDescription
        self.thumbnail = thumbnail
    }
    
    required convenience init(from decoder: Decoder) throws {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.init(context: managedContext)
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(Int64.self, forKey: .id)
            self.name = try container.decode(String.self, forKey: .name)
            self.characterDescription = try container.decode(String.self, forKey: .characterDescription)
            self.thumbnail = try container.decode(Thumbnail.self, forKey: .thumbnail)
        } catch {
            print("Error retriving questions \(error)")
        }
    }
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case characterDescription = "description"
        case name = "name"
        case thumbnail = "thumbnail"
    }
    
    // MARK: - Core Data - DAO
    class func fetchRequest() -> NSFetchRequest<Character> {
        return NSFetchRequest(entityName: "Character")
    }
    
    func save(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    class func load(_ fetchedResultController: NSFetchedResultsController<Character>) {
        do {
            try fetchedResultController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    class func getSearcher() -> NSFetchedResultsController<Character> {
        let searcher: NSFetchedResultsController<Character> = {
                var fetchRequest: NSFetchRequest<Character> = Character.fetchRequest()
                let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
                fetchRequest.sortDescriptors = [sortDescriptor]
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                return NSFetchedResultsController(fetchRequest: fetchRequest,
                                                  managedObjectContext: appDelegate.persistentContainer.viewContext,
                                                  sectionNameKeyPath: nil,
                                                  cacheName: nil)
            }()

        return searcher
    }
}

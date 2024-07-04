//
//  CharacterDao.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 17/05/24.
//

import Foundation
import CoreData

class CharacterDao {
    private class func fetchRequest() -> NSFetchRequest<Character> {
        return NSFetchRequest(entityName: "Character")
    }
    
    class func load(_ fetchedResultController: NSFetchedResultsController<Character>) {
        do {
            try fetchedResultController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    class func save(_ character: Character) {
        let context = CoreDataManager.getContext()
                
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Character", into: context)
        entity.setValue(character.id, forKey: "id")
        entity.setValue(character.name, forKey: "name")
        entity.setValue(character.characterDescription, forKey: "characterDescription")
        entity.setValue(character.thumbnail, forKey: "thumbnail")
    }
    
    class func findCharacters() -> [Character] {
        let sort = NSSortDescriptor(key: "name", ascending: true)
                
        let fetchRequest: NSFetchRequest<Character> = self.fetchRequest()
        fetchRequest.sortDescriptors = [sort]
        
        do {
            return try CoreDataManager.getContext().fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    class func deleteCharacter(_ character: Character) {
        let context = CoreDataManager.getContext()
        let coord = context.persistentStoreCoordinator
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Character")
        
        //Here is the field on which u need to chk which record u want to delete just pass here in value ( acutal value) unique key = field in coredata
        let predicate = NSPredicate(format: "id == %@", character.id)
        fetchRequest.predicate = predicate
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try coord!.execute(deleteRequest, with: context)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    class func cleanCoreData() {
        let fetchRequest:NSFetchRequest<Character> = self.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        do {
            try CoreDataManager.getContext().execute(deleteRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

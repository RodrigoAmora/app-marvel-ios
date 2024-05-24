//
//  CharacterDao.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 17/05/24.
//

import Foundation
import UIKit
import CoreData

class CharacterDao {
    private class func fetchRequest() -> NSFetchRequest<Character> {
        return NSFetchRequest(entityName: "Character")
    }
    
    func salvar(_ context: NSManagedObjectContext) {
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
    
    class func save(_ character: Character) {
        let context = CoreDataManager.getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Character", in: context)
        
        let managedObj = NSManagedObject(entity: entity!, insertInto: context)
        managedObj.setValue(character.id, forKey: "id")
        managedObj.setValue(character.name, forKey: "name")
        managedObj.setValue(character.characterDescription, forKey: "characterDescription")
        managedObj.setValue(character.thumbnail, forKey: "thumbnail")
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    class func findCharacters() -> NSFetchedResultsController<Character> {
        let searcher: NSFetchedResultsController<Character> = {
            let fetchRequest: NSFetchRequest<Character> = self.fetchRequest()
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

//
//  ThumbnailDao.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 07/06/24.
//

import Foundation
import CoreData

class ThumbnailDao {
    private class func fetchRequest() -> NSFetchRequest<Thumbnail> {
        return NSFetchRequest(entityName: "Thumbnail")
    }
    
    class func load(_ fetchedResultController: NSFetchedResultsController<Character>) {
        do {
            try fetchedResultController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    class func save(_ thumbnail: Thumbnail) {
        let context = CoreDataManager.getContext()
                
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Thumbnail", into: context)
        entity.setValue(thumbnail.path, forKey: "path")
        entity.setValue(thumbnail.extensionPhoto, forKey: "extensionPhoto")
    }
    
    class func cleanCoreData() {
        let fetchRequest:NSFetchRequest<Thumbnail> = self.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        do {
            try CoreDataManager.getContext().execute(deleteRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
}

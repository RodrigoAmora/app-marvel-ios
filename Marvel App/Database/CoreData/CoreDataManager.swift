//
//  CoreDataManager.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 17/05/24.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager: NSObject {
    class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}

//
//  CoreDataStack.swift
//  Attendance
//
//  Created by Stan on 2017-12-02.
//  Copyright © 2017 Stan Guo. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }

    lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent(self.modelName + ".sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    func createNewItemWithName(name: String) -> AnyObject
    {
        let obj = NSEntityDescription.insertNewObject(forEntityName: name, into: managedObjectContext) as AnyObject
        
        return obj
    }
    
    func save() {
        let moc = managedObjectContext
        
        moc.performAndWait {
            
            do {
            
                try  moc.save()
             
                
            } catch  let error as NSError{
                print("连接失败\(error.domain)")
                abort()
            }
        }
    }
    
    func objectWithID(objectID: NSManagedObjectID) -> NSManagedObject {
        return managedObjectContext.object(with: objectID)
    }
    
    func deleteObject(object: NSManagedObject) {
        let moc = managedObjectContext
        moc.performAndWait {
            moc.delete(object)
        }
    }
    
    
    @available(iOS 10.0, *)
    lazy var storeContainer: NSPersistentContainer = {
       let container = NSPersistentContainer(name: self.modelName)
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                debugPrint("Unclear error\(error)")
            }
        })
        return container
    }()
    
    @available(iOS 10.0, *)
    lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    @available(iOS 10.0, *)
    func saveContext() {
       
            guard managedContext.hasChanges else { return }

        do {
                try managedContext.save()
            
        } catch let error as NSError {
            debugPrint("Unclear error\(error)")
        }
        
    }
}




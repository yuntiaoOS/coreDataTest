////
////  File.swift
////  swift-coreDataTest
////
////  Created by jcgf on 2018/4/24.
////  Copyright © 2018年 jcgf. All rights reserved.
////
//
//import Foundation
//import CoreData
//
//public class SCCoreData{
//    
//    struct SCCoreDatsStruct {
//        static var modelName:String = ""
//        static var token:dispatch_once_t = 0
//        static var instance:SCCoreData? = nil
//    }
//    
//    /// 获取单例
//    class func sharedInstance(#modelName:String)->SCCoreData{
//        
//        //只会运行一次
//        dispatch_once(&SCCoreDatsStruct.token){
//            
//            SCCoreDatsStruct.instance = SCCoreData()
//        }
//        
//        SCCoreDatsStruct.modelName = modelName
//        
//        return SCCoreDatsStruct.instance!
//    }
//    
//    
//    /// 数据库路径
//    lazy var applicationDocumentsDirectory: NSURL = {
//        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
//        return urls[urls.count-1] as! NSURL
//    }()
//    
//    /// 整个对象模型
//    lazy var managedObjectModel: NSManagedObjectModel = {
//        
//        let name = SCCoreDatsStruct.modelName
//        
//        let modelURL = NSBundle.mainBundle().URLForResource(name, withExtension: "momd")!
//        return NSManagedObjectModel(contentsOfURL: modelURL)!
//    }()
//    
//    
//    /// 持久化助理
//    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
//        
//        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
//        
//        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("db.sqlite")
//        
//        var error: NSError? = nil
//        
//        var failureReason = "There was an error creating or loading the application's saved data."
//        
//        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil
//        {
//            coordinator = nil
//            var dict = [String: AnyObject]()
//            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
//            dict[NSLocalizedFailureReasonErrorKey] = failureReason
//            dict[NSUnderlyingErrorKey] = error
//            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
//            NSLog("Unresolved error \(error), \(error!.userInfo)")
//            abort()
//        }
//        
//        return coordinator
//    }()
//    
//    
//    /// 对象管理上下文
//    lazy var managedObjectContext: NSManagedObjectContext? = {
//        let coordinator = self.persistentStoreCoordinator
//        
//        if coordinator == nil {
//            return nil
//        }
//        var managedObjectContext = NSManagedObjectContext()
//        managedObjectContext.persistentStoreCoordinator = coordinator
//        return managedObjectContext
//    }()
//    
//    
//    /// 最终保存数据
//    func saveContext () {
//        if let moc = self.managedObjectContext {
//            var error: NSError? = nil
//            if moc.hasChanges && !moc.save(&error) {
//                NSLog("Unresolved error \(error), \(error!.userInfo)")
//                abort()
//            }
//        }
//    }
//}


////
////  File.swift
////  swift-coreDataTest
////
////  Created by jcgf on 2018/4/24.
////  Copyright © 2018年 jcgf. All rights reserved.
////
//import Foundation
//import CoreData
//
//
//
//public class SCCoreDataHelper{
//    
//    /*
// 
//     //查询数据库中是否已经有Token数据了
//     let result = SCCoreDataHelper.query("Token", whereString: "")
//     //有数据，那就更新
//     if result?.count != 0{
//     for obj in result!{
//     obj.setValue(token, forKey: "access_token")
//     }
//     
//     }else{
//     //没有数据，那就add
//     
//     let d = ["access_token":token!,"refresh_token": reftoken! , "expires_in": expiresin!,"uid":uid!]
//     
//     SCCoreDataHelper.add("Token", data: d.toDictionary())
//     }
//     SCCoreDataHelper.save()
// 
// 
// */
//    
//    
//    //这里的Model参数要修改为xcdatamodeld的文件名
//    static var coreDataInstance = SCCoreData.sharedInstance(modelName:"swift-coreDataTest")
//    
//    static var coreDataContext = coreDataInstance.managedObjectContext
//    
//    
//    /// 根据指定对象名称  获取NSManagedObject对象
//    class func getManagedObject(objectName:String)->NSManagedObject?{
//        
//        var managedObject = NSEntityDescription.insertNewObjectForEntityForName(objectName, inManagedObjectContext: coreDataContext!) as? NSManagedObject
//        
//        return managedObject
//    }
//    
//    /// 保存数据
//    class func save(){
//        coreDataInstance.saveContext()
//    }
//    
//    /// 插入数据
//    class func add(tableName:String,data:[String:AnyObject]){
//        
//        var object = getManagedObject(tableName)
//        
//        if let obj = object{
//            
//            for (key,value) in data{
//                obj.setValue(value, forKey: key)
//            }
//        }
//    }
//    
//    /// 删除一条数据
//    class func delete(managedObject:NSManagedObject){
//        coreDataContext?.deleteObject(managedObject)
//    }
//    
//    /// 创建一个谓词对象，包含了过滤条件
//    class func queryPredicate(whereString:String)->NSPredicate{
//        return NSPredicate(format: whereString)
//    }
//    
//    /// 创建一个查询请求对象
//    class func queryRequest(tableName:String,whereString:String)->NSFetchRequest{
//        
//        var fetchRequest = NSFetchRequest(entityName: tableName)
//        
//        if  whereString != ""{
//            let predicate = queryPredicate(whereString)
//            fetchRequest.predicate = predicate
//        }
//        return  fetchRequest
//    }
//    
//    
//    
//    /// 执行一个查询操作，返回包含查询结果的NSManagedObject数组
//    class func query(tableName:String,whereString:String)->[NSManagedObject]? {
//        
//        let fetchRequest = queryRequest(tableName, whereString: whereString)
//        return coreDataContext?.executeFetchRequest(fetchRequest, error: nil) as? [NSManagedObject]
//    }
//    
//}


//
//  ViewController.swift
//  swift-coreDataTest
//
//  Created by jcgf on 2018/4/23.
//  Copyright © 2018年 jcgf. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    lazy var dataFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    
    var managedContext: NSManagedObjectContext!
    
    
    var currentWorker: Worker?
    
    @IBOutlet var textL: UILabel!
    
    var indexP = 0
    
    
   
    @IBAction func clickAction(_ sender: Any) {
        var attendance: AttendanceTime
        if #available(iOS 10.0, *) {
            attendance = AttendanceTime(context: managedContext)
        } else {
            attendance = coreDataStack.createNewItemWithName(name:"AttendanceTime") as! AttendanceTime
        }
        attendance.date = Date() as NSDate
        
        let attendArray : NSOrderedSet = (currentWorker?.attendances)!
        var dateStr = ""
        
        for attend in attendArray {
            dateStr = dateStr + ((attend as! AttendanceTime).date?.description)!
        }
        
        if #available(iOS 10.0, *) {
            currentWorker?.addToAttendances(attendance)
        }else{
            let works = currentWorker?.attendances?.mutableCopy() as! NSMutableOrderedSet
            works.add(attendance)
            currentWorker?.attendances = works.copy() as? NSOrderedSet
        }
        
        
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            debugPrint("context save error:\(error),description:\(error.userInfo)")
        }
        
    
        
        textL?.text = dateStr
        indexP = indexP + 1
    }
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let workerName = "Frank"
        let workerFetch: NSFetchRequest<Worker> = Worker.fetchRequest()
        workerFetch.predicate = NSPredicate(format: "%K == %@", #keyPath(Worker.name),workerName)
        do {
            let results = try managedContext.fetch(workerFetch)
            for val in results {
                managedContext.delete(val)
            }
            try managedContext.save()
            
            
            if results.count > 0 {
                //                this person have found
                currentWorker = results.first
                
            
            } else {
                //                this person have not found, so create this person's name as the ID
                if #available(iOS 10.0, *) {
                    currentWorker = Worker(context: managedContext)
                } else {
                
                    currentWorker = coreDataStack.createNewItemWithName(name:"Worker") as? Worker
                    
                    
                }
                currentWorker?.name = workerName
                currentWorker?.avatar = UIImagePNGRepresentation(UIImage.init(named: "attendance_hands")!) as! NSData
                
                try managedContext.save()
                
                
                
            }
        } catch let error as NSError {
            debugPrint("ViewController Fetch error:\(error), description:\(error.userInfo)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



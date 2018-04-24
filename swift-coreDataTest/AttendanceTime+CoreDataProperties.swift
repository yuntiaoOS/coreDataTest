//
//  AttendanceTime+CoreDataProperties.swift
//  swift-coreDataTest
//
//  Created by jcgf on 2018/4/24.
//  Copyright © 2018年 jcgf. All rights reserved.
//
//

import Foundation
import CoreData


extension AttendanceTime {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AttendanceTime> {
        return NSFetchRequest<AttendanceTime>(entityName: "AttendanceTime")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var workers: Worker?

}

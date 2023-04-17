//
//  ToDoListItem+CoreDataProperties.swift
//  CoreDataApp
//
//  Created by Canadore Student on 2023-04-17.
//  Copyright © 2023 Canadore Student. All rights reserved.
//
//

import Foundation
import CoreData


extension ToDoListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoListItem> {
        return NSFetchRequest<ToDoListItem>(entityName: "ToDoListItem")
    }

    @NSManaged public var fName: String?
    @NSManaged public var lName: String?

}

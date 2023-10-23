//
//  LastFiles+CoreDataProperties.swift
//  AnalogOfDisk
//
//  Created by Ольга on 20.10.2023.
//
//

import Foundation
import CoreData


extension LastFiles {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LastFiles> {
        return NSFetchRequest<LastFiles>(entityName: "LastFiles")
    }

    @NSManaged public var name: String
    @NSManaged public var path: String
    @NSManaged public var size: Int64
    @NSManaged public var date: String
    @NSManaged public var file: String
    @NSManaged public var id: String
    @NSManaged public var preview: String
    @NSManaged public var type: String
    

}

extension LastFiles : Identifiable {

}


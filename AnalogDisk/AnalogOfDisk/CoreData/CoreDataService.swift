//
//  CoreDataService.swift
//  AnalogOfDisk
//
//  Created by Ольга on 19.10.2023.
//

import Foundation
import CoreData
import UIKit

protocol CoreDataServiceProtocol {
    func checkFile(context: NSManagedObjectContext, networkFiles: NetworkFilesItem)
    func getRecentFiles(context: NSManagedObjectContext) -> [LastFiles]
    func getViewContext() -> NSManagedObjectContext
    func getBackgroundContext() -> NSManagedObjectContext
    func deleteFiles(files: [LastFiles], context: NSManagedObjectContext)
}

class CoreDataService: CoreDataServiceProtocol {
    func getViewContext() -> NSManagedObjectContext {
        return container.viewContext
    }
    func getBackgroundContext() -> NSManagedObjectContext {
        let context = container.newBackgroundContext()
        return context
    }
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataBase")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Error: " + error.localizedDescription)
            }
            container.viewContext.automaticallyMergesChangesFromParent = true
        }
        return container
    }()
    
    func saveRecentFiles(object: LastFiles, networkFiles: NetworkFilesItem) {
        object.path = networkFiles.path
        object.name = networkFiles.name
        object.date = dateFormatFrom(dateString: networkFiles.date)
        object.size = Int64(networkFiles.size)
        object.id = networkFiles.id
        object.preview = networkFiles.preview
        object.type = networkFiles.type
        object.file = networkFiles.file
    }
    func dateFormatFrom(dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        guard let toDate = formatter.date(from: dateString) else { return ""}
        formatter.dateFormat = "yyyy.MM.dd HH:mm"
        return formatter.string(from: toDate)
    }
    
    func checkFile(context: NSManagedObjectContext, networkFiles: NetworkFilesItem) {
        let fetchRequest: NSFetchRequest<LastFiles>
        fetchRequest = LastFiles.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", networkFiles.id)
        let objects = try? context.fetch(fetchRequest)
        
        if objects?.count == 0 {
            let file = LastFiles.init(entity: NSEntityDescription.entity(forEntityName: "LastFiles", in: context)!, insertInto: context)
            saveRecentFiles(object: file, networkFiles: networkFiles)
        } else {
            saveRecentFiles(object: objects!.first!, networkFiles: networkFiles)
        }
        
    }
    
    func getRecentFiles(context: NSManagedObjectContext) -> [LastFiles] {
        let fetchRequest: NSFetchRequest<LastFiles>
        fetchRequest = LastFiles.fetchRequest()
        let fileArray = try? context.fetch(fetchRequest)
        return fileArray ?? []
    }
    
    func deleteFiles(files: [LastFiles], context: NSManagedObjectContext) {
        files.forEach({context.delete($0)})
    }
}

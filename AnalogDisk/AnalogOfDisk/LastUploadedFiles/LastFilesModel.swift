//
//  ListModel.swift
//  AnalogOfDisk
//
//  Created by Ольга on 19.10.2023.
//

import Foundation
import CoreData

protocol LastFilesModelProtocol {
    func cellData(indexPath: IndexPath) -> LastFiles?
    func numberOfRows(section: Int) -> Int?
    func loadPersistentStores()
    var onReloadView: (()->())? {get set}
}

class LastFilesModel: NSObject, LastFilesModelProtocol {
    
    let coredataService: CoreDataServiceProtocol
    var onReloadView: (()->())?

    private lazy var fetchedResultsController: NSFetchedResultsController<LastFiles> = {
        let fetchRequest = LastFiles.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.coredataService.getViewContext(), sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        return fetchedResultController
    }()
    
    init(coredataService: CoreDataServiceProtocol) {
        self.coredataService = coredataService
    }
  
    func loadPersistentStores() {
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
    }
    
    func cellData(indexPath: IndexPath) -> LastFiles? {
        return fetchedResultsController.object(at: indexPath)
    }
    
    func numberOfRows(section: Int) -> Int? {
        return fetchedResultsController.sections?[section].numberOfObjects
    }
}

extension LastFilesModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        onReloadView?()
    }
}

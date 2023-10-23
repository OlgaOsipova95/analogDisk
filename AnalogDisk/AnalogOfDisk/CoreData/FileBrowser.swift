//
//  FileBrowser.swift
//  AnalogOfDisk
//
//  Created by Ольга on 19.10.2023.
//

import Foundation

protocol FileBrowserProtocol {
    func updateData(networkFiles: [NetworkFilesItem], coreData: CoreDataServiceProtocol)
}

class FileBrowser: FileBrowserProtocol {
    private init() {}
    static func shared() -> FileBrowser {
        return FileBrowser()
    }
    func updateData(networkFiles: [NetworkFilesItem], coreData: CoreDataServiceProtocol) {
        let context = coreData.getBackgroundContext()
        var filesToDelete = coreData.getRecentFiles(context: context)
        for item in networkFiles {
            coreData.checkFile(context: context, networkFiles: item)
            if let index = filesToDelete.firstIndex(where: { $0.id == item.id }) {
                filesToDelete.remove(at: index)
            }
        }
        coreData.deleteFiles(files: filesToDelete, context: context)
        try? context.save()
    }
}

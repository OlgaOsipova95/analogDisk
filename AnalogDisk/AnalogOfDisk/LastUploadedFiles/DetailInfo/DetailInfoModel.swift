//
//  DetailInfoModel.swift
//  AnalogOfDisk
//
//  Created by Дмитрий on 20.10.2023.
//

import Foundation

protocol DetailInfoModelProtocol {
    func getPath() -> String
    func getTitle() -> String
    func getFileURL() -> URL
    func getID() -> String
}

class DetailInfoModel {

    var fileInfo: LastFiles
    init(file: LastFiles) {
        self.fileInfo = file
    }
    
}
extension DetailInfoModel: DetailInfoModelProtocol {
    func getFileURL() -> URL {
        guard let url = URL(string: fileInfo.file) else { return URL(string: "")!}
        return url
    }
    func getPath() -> String {
        return fileInfo.path
    }
    func getTitle() -> String {
        return fileInfo.name
    }
    func getID() -> String {
        return fileInfo.type
    }
}

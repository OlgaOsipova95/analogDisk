//
//  PageModel.swift
//  AnalogOfDisk
//
//  Created by Ольга on 18.10.2023.
//

import Foundation
import UIKit

protocol PageModelProtocol {
    func getImage() -> UIImage
    func getDescription() -> String
    func getIndex() -> Int
}

class PageModel {
    private let nameImage: String
    private let description: String
    private let index: Int
    
    init(nameImage: String, description: String, index: Int) {
        self.nameImage = nameImage
        self.description = description
        self.index = index
    }
}

extension PageModel: PageModelProtocol {
    func getImage() -> UIImage {
        guard let image = UIImage(named: nameImage) else { return UIImage() }
        return image
    }
    
    func getDescription() -> String {
        return description
    }
    
    func getIndex() -> Int {
        return index
    }
}

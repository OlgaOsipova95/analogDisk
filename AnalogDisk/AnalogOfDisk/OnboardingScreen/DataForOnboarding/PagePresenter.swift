//
//  PagePresenter.swift
//  AnalogOfDisk
//
//  Created by Ольга on 18.10.2023.
//

import Foundation
import UIKit

protocol PagePresenterProtocol {
    func setView(_ view: PageViewProtocol)
    func setImage() -> UIImage
    func setDescription() -> String
    func setIndex() -> Int
}

class PagePresenter {
    private var view: PageViewProtocol?
    private var model: PageModelProtocol
    init(model: PageModelProtocol) {
        self.model = model
    }
}

extension PagePresenter: PagePresenterProtocol {
    func setView(_ view: PageViewProtocol) {
        self.view = view
    }
    func setImage() -> UIImage {
        return model.getImage()
    }
    func setDescription() -> String {
        return model.getDescription()
    }
    func setIndex() -> Int {
        return model.getIndex()
    }
}

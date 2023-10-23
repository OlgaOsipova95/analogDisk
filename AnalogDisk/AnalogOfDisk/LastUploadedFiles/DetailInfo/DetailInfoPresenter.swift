//
//  DetailInfoPresenter.swift
//  AnalogOfDisk
//
//  Created by Дмитрий on 20.10.2023.
//

import Foundation
import UIKit

protocol DetailInfoPresenterProtocol {
    func setView(view: DetailInfoViewProtocol)
    func deleteFile()
    func shareData()
    func shareLink()
    func getTitle() -> String
}

class DetailInfoPresenter {
    var view: DetailInfoViewProtocol?
    let model: DetailInfoModelProtocol

    init(model: DetailInfoModelProtocol) {
        self.model = model
    }
}
extension DetailInfoPresenter: DetailInfoPresenterProtocol {
    func setView(view: DetailInfoViewProtocol) {
        self.view = view
    }
    func getTitle() -> String {
        return model.getTitle()
    }
    func deleteFile() {
        NetworkService().deleteFile(path: model.getPath()) {
            self.view?.openPreviousVC()
        }
    }
    func shareData() {
        guard let file = try? Data(contentsOf: model.getFileURL()) else { return }
        let fileToShare = [file]
        self.view?.shareFile(data: fileToShare)
    }
    func shareLink() {
        NetworkService().shareLink(path: model.getPath()) { link in
            let link = [link]
            self.view?.shareFile(data: link)
        }
    }
}

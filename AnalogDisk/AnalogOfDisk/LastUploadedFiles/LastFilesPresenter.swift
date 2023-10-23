//
//  ListPresenter.swift
//  AnalogOfDisk
//
//  Created by Ольга on 19.10.2023.
//

import Foundation
import UIKit
import SDWebImage

protocol LastFilesPresenterProtocol {
    func setView(view: LastFilesViewProtocol)
    func numberOfRowsInSection(section: Int) -> Int?
    func prepareCell(cell: TableViewCell, indexPath: IndexPath)
    func loadPersistentStores()
    func didSelectItem(indexPath: IndexPath)
}

class LastFilesPresenter: NSObject, LastFilesPresenterProtocol {
    
    var view: LastFilesViewProtocol?
    var model: LastFilesModelProtocol
    init(model: LastFilesModelProtocol) {
        self.model = model
        super.init()
        self.model.onReloadView = {
            self.view?.reloadContent()
        }
    }
    
    func setView(view: LastFilesViewProtocol) {
        self.view = view
    }
    func numberOfRowsInSection(section: Int) -> Int? {
        return model.numberOfRows(section: section)
    }
    func prepareCell(cell: TableViewCell, indexPath: IndexPath) {
        guard let file = model.cellData(indexPath: indexPath) else { return }
        cell.headerLabel.text = file.name
        cell.dateLabel.text = file.date
        cell.sizeLabel.text = ByteCountFormatter.string(fromByteCount: file.size, countStyle: .file)
        guard let imageURL = URL(string: file.preview) else { return }
        SDWebImageDownloader.shared.setValue("OAuth " + (SessionStorage().accessToken ?? ""), forHTTPHeaderField: "Authorization")
        cell.roundImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.roundImageView.sd_setImage(with: imageURL)
    }
    func didSelectItem(indexPath: IndexPath) {
        guard let file = model.cellData(indexPath: indexPath) else { return }
        view?.showDetailInfo(file: file)
    }
    
    func loadPersistentStores() {
        model.loadPersistentStores()
    }
    
}

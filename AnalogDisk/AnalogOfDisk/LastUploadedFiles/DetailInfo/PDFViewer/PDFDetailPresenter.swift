//
//  PDFDetailPresenter.swift
//  AnalogOfDisk
//
//  Created by Дмитрий on 21.10.2023.
//

import Foundation

protocol PdfDetailPresenterProtocol: DetailInfoPresenterProtocol {
    func loadData()
}
class PdfDetailPresenter: DetailInfoPresenter, PdfDetailPresenterProtocol {
    var viewPdfViewer: PdfDetailViewProtocol? {
        return view as! PdfDetailViewProtocol?
    }
    var dataProvider: DataProvider
    init(model: DetailInfoModelProtocol, dataProvider: DataProvider) {
        self.dataProvider = dataProvider
        super.init(model: model)
    }
    func loadData() {
        dataProvider.downloadFile(id: model.getID(), url: model.getFileURL()) { progress in
            self.viewPdfViewer?.showDownloadProgress(progress: progress)
        } completion: { data in
            self.viewPdfViewer?.openPDF(document: data)
        }
    }
}
    

//
//  PDFViewer.swift
//  AnalogOfDisk
//
//  Created by Дмитрий on 21.10.2023.
//

import Foundation
import PDFKit

protocol PdfDetailViewProtocol {
    func openPDF(document: Data)
    func showDownloadProgress(progress: Float)
}

class PdfDetailViewController: DetailInfoViewController {
    var presenterPdfViewer: PdfDetailPresenterProtocol {
        return presenter as! PdfDetailPresenterProtocol
    }

    var pdfView = PDFView()
    var pdfDocument: PDFDocument? {
        didSet {
            pdfView.document = pdfDocument
            downloadProgress.isHidden = true
        }
    }
    var downloadProgress = UIProgressView(progressViewStyle: .default)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.setView(view: self)
        setupConstraints()
        presenterPdfViewer.loadData()
    }
}

extension PdfDetailViewController: PdfDetailViewProtocol {
    func openPDF(document: Data) {
        pdfDocument = PDFDocument(data: document)
        pdfView.autoScales = true
    }
    func showDownloadProgress(progress: Float) {
        downloadProgress.setProgress(progress, animated: true)
    }
}

extension PdfDetailViewController {
    func setupConstraints() {
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        downloadProgress.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pdfView)
        self.view.addSubview(downloadProgress)
        
        downloadProgress.isHidden = false
        pdfView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(view.snp.bottom)
        }
        downloadProgress.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            make.centerY.equalTo(view.safeAreaLayoutGuide.snp.centerY)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
        }
    }
}

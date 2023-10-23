//
//  DocumentDetailPresenter.swift
//  AnalogOfDisk
//
//  Created by Дмитрий on 21.10.2023.
//

import Foundation

protocol DocumentDetailPresenterProtocol: DetailInfoPresenterProtocol {
    func getURLRequest() -> URLRequest
}
class DocumentDetailPresenter: DetailInfoPresenter, DocumentDetailPresenterProtocol {
    func getURLRequest() -> URLRequest {
        return URLRequest(url: model.getFileURL())
    }
}

//
//  ImageDetailPresenter.swift
//  AnalogOfDisk
//
//  Created by Дмитрий on 21.10.2023.
//

import Foundation

protocol ImageDetailPresenterProtocol: DetailInfoPresenterProtocol {
    func setImage() -> URL
}
class ImageDetailPresenter: DetailInfoPresenter, ImageDetailPresenterProtocol {
    
    func setImage() -> URL {
        return model.getFileURL()
    }
}

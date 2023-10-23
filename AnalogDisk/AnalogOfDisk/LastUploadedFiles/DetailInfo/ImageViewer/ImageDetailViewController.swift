//
//  ImageDetailViewController.swift
//  AnalogOfDisk
//
//  Created by Дмитрий on 21.10.2023.
//

import Foundation
import UIKit
import SDWebImage

protocol ImageDetailViewProtocol {
    func showImage()
}

class ImageDetailViewController: DetailInfoViewController {
    var presenterImageViewer: ImageDetailPresenterProtocol {
        return presenter as! ImageDetailPresenterProtocol
    }
    
    var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.setView(view: self)
        showImage(url: presenterImageViewer.setImage())
        setupConstraints()
    }
    
    func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
        }
    }
}

extension ImageDetailViewController {
    func showImage(url: URL) {
        imageView.sd_imageIndicator = SDWebImageProgressIndicator.default
        imageView.sd_imageIndicator?.indicatorView.tintColor = .lightGray
        imageView.sd_setImage(with: url)
    }
}

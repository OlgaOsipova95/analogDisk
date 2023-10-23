//
//  PageViewController.swift
//  AnalogOfDisk
//
//  Created by Ольга on 18.10.2023.
//

import Foundation
import UIKit
import SnapKit

protocol PageViewProtocol {
    
}

class PageViewController: UIViewController {
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    private let pageControl: UIPageControl = {
        let page = UIPageControl()
        page.currentPageIndicatorTintColor = .blue
        page.pageIndicatorTintColor = .gray
        page.numberOfPages = 3
        return page
    }()
    private let stack = UIStackView()
    var presenter: PagePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setData()
    }
    func setData() {
        imageView.image = presenter?.setImage()
        descriptionLabel.text = presenter?.setDescription()
        pageControl.currentPage = presenter?.setIndex() ?? 0
    }
}

extension PageViewController {
    func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        stack.addSubview(imageView)
        stack.addSubview(descriptionLabel)
        stack.addSubview(pageControl)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(stack.snp.top)
            make.centerX.equalTo(stack.snp.centerX)
            make.width.height.equalTo(150)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(64)
            make.centerX.equalTo(imageView.snp.centerX)
        }
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(stack.snp.bottom)
            make.centerX.equalTo(imageView.snp.centerX)
        }
        self.view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.centerY.equalTo(view.safeAreaLayoutGuide.snp.centerY).offset(-50)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.height.equalTo(350)
        }
    }
}

//
//  ListViewController.swift
//  AnalogOfDisk
//
//  Created by Ольга on 19.10.2023.
//

import Foundation
import SnapKit
import UIKit

protocol LastFilesViewProtocol {
    func reloadContent()
    func showDetailInfo(file: LastFiles)
}

class LastFilesViewController: UIViewController {
    
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()

    let cellIdentifier = "cell"
    let networkService = NetworkService()
    let coreData: CoreDataServiceProtocol = CoreDataService()
    let dataProvider = DataProvider()
    
    lazy var presenter: LastFilesPresenterProtocol = LastFilesPresenter(model: LastFilesModel(coredataService: coreData))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setView(view: self)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        refreshControl.addTarget(self, action: #selector(reloadTableView), for: .valueChanged)
        presenter.loadPersistentStores()
        setupView()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        self.updateFiles()
        tableView.reloadData()
    }
}

extension LastFilesViewController: LastFilesViewProtocol {
    func reloadContent() {
        tableView.reloadData()
    }
    func showDetailInfo(file: LastFiles) {
        var detailVC = DetailInfoViewController()
        let model = DetailInfoModel(file: file)
        if file.type.contains("image") {
            detailVC = ImageDetailViewController()
            detailVC.presenter = ImageDetailPresenter(model: model)
        } else {
            if file.type.contains("pdf") {
                detailVC = PdfDetailViewController()
                detailVC.presenter = PdfDetailPresenter(model: model, dataProvider: dataProvider)
            } else {
                if file.type.contains("word") {
                    detailVC = DocumentDetailViewController()
                    detailVC.presenter = DocumentDetailPresenter(model: model)
                }
            }
        }
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension LastFilesViewController {
    
    @objc func reloadTableView() {
        self.updateFiles()
        refreshControl.endRefreshing()
    }
    func updateFiles() {
        networkService.updateRecentFiles { items in
            FileBrowser.shared().updateData(networkFiles: items, coreData: self.coreData)
        }
    }
}

extension LastFilesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection(section: section) ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TableViewCell else { return UITableViewCell() }
        presenter.prepareCell(cell: cell, indexPath: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectItem(indexPath: indexPath)
    }
}

extension LastFilesViewController {
    func setupNavigationBar() {
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.tintColor = .black
        navigationItem.title = NSLocalizedString("list_vc.title", comment: "")
    }
    func setupView() {
        tableView.rowHeight = 55
        tableView.separatorStyle = .none
        tableView.refreshControl = refreshControl
        view.addSubview(tableView)
    }
    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}


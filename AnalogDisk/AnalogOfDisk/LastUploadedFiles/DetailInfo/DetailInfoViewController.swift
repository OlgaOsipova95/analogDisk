//
//  DetailInfoViewController.swift
//  AnalogOfDisk
//
//  Created by Дмитрий on 20.10.2023.
//

import Foundation
import UIKit

protocol DetailInfoViewProtocol {
    func shareFile<T>(data: [T])
    func openPreviousVC()
}

protocol ActionsForFileProtocol {
    func renameFile()
    func deleteFile(completion: @escaping ()->Void)
    func shareData(shareFile: @escaping ()->Void, shareLink: @escaping ()->Void)
}

class DetailInfoViewController: UIViewController {
    
    var presenter: DetailInfoPresenterProtocol?
    var menu: UIMenu {
        return UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
    }
    var menuItems: [UIAction] {
        return [
            UIAction(title: NSLocalizedString("rename_vc.title", comment: ""), image: UIImage(named: "icon_edit"), handler: { _ in
                
            }
                    ),
            UIAction(title: NSLocalizedString("alertController.trash_image.button", comment: ""), image: UIImage(named: "icon_trash"), handler: { _ in
                self.deleteFile {
                    self.presenter?.deleteFile()
                }
            }),
            UIAction(title: NSLocalizedString("alertController.share_image.button_File", comment: ""), image: UIImage(named: "icon_share"), handler: { _ in
                self.shareData(shareFile: {
                    self.presenter?.shareData()
                }, shareLink: {
                    self.presenter?.shareLink()
                })
            })
        ]
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.setView(view: self)
        setupNavigationBar()
    }
}

extension DetailInfoViewController: DetailInfoViewProtocol {
    func openPreviousVC() {
        self.navigationController?.popViewController(animated: true)
    }
    func shareFile<T>(data: [T]) {
        let activityViewController = UIActivityViewController(activityItems: data, applicationActivities: nil)
        self.present(activityViewController, animated: true)
    }
}
extension DetailInfoViewController: ActionsForFileProtocol {
    func renameFile() {

    }
    
    func deleteFile(completion: @escaping ()->Void) {
        let alertController = UIAlertController(title: NSLocalizedString("alertController.trash_image.title", comment: ""), message: "", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("alertController.trash_image.button", comment: ""), style: .destructive, handler: { _ in
            completion()
        }))
        alertController.addAction(UIAlertAction(title: NSLocalizedString("alertController.trash_image.cancel", comment: ""), style: .cancel))
        self.present(alertController, animated: true)
    }
    
    func shareData(shareFile: @escaping ()->Void, shareLink: @escaping ()->Void) {
        let alertController = UIAlertController(title: NSLocalizedString("alertController.share_image.title", comment: ""), message: "", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("alertController.share_image.button_File", comment: ""), style: .default,  handler: { _ in
            shareFile()
        }))
        alertController.addAction(UIAlertAction(title: NSLocalizedString("alertController.share_image.button_URL", comment: ""), style: .default, handler: { _ in
            shareLink()
        }))
        alertController.addAction(UIAlertAction(title: NSLocalizedString("alertController.trash_image.cancel", comment: ""), style: .cancel))
        self.present(alertController, animated: true)
    }
}

extension DetailInfoViewController {
    
    func setupNavigationBar() {
        
        navigationItem.title = presenter?.getTitle()
        if #available(iOS 14.0, *) {
            let barButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "list.bullet"), primaryAction: nil, menu: self.menu)
            navigationItem.rightBarButtonItem = barButton
        } else {
            // Fallback on earlier versions
        }
    }
}

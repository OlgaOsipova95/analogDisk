//
//  DocumentDetailViewController.swift
//  AnalogOfDisk
//
//  Created by Дмитрий on 21.10.2023.
//

import Foundation
import WebKit

protocol DocumentDetailViewProtocol {
    
}

class DocumentDetailViewController: DetailInfoViewController {
    var presenterDocumentViewer: DocumentDetailPresenterProtocol {
        return presenter as! DocumentDetailPresenterProtocol
    }
    var webView = WKWebView()
    var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.tintColor = .gray
        view.hidesWhenStopped = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.setView(view: self)
        webView.navigationDelegate = self
        setupConstraints()
        webView.load(presenterDocumentViewer.getURLRequest())
    }
}
extension DocumentDetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
}

extension DocumentDetailViewController {
    func setupConstraints() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.startAnimating()
        view.addSubview(webView)
        view.addSubview(activityIndicator)
        
        webView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
        }
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide.snp.center)
        }
    }
}

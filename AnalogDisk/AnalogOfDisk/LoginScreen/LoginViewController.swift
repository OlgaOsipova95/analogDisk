//
//  LoginViewController.swift
//  AnalogOfDisk
//
//  Created by Ольга on 19.10.2023.
//

import Foundation
import UIKit
import WebKit

protocol LoginViewProtocol {
    var didFinish: (()->Void)? { get set }
}

class LoginViewController: UIViewController {

    private let webView = WKWebView()
    let presenter: LoginPresenterProtocol = LoginPresenter(model: LoginModel(sessionStorage: SessionStorage()))
    var didFinish: (()->Void)?
    
    override func loadView() {
        super.loadView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setView(self)
        webView.navigationDelegate = presenter
        webView.uiDelegate = presenter
        webView.load(presenter.getURLRequest())
    }
}

extension LoginViewController: LoginViewProtocol {
    
}

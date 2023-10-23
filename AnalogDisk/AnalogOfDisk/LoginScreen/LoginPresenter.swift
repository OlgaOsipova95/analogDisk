//
//  LoginPresenter.swift
//  AnalogOfDisk
//
//  Created by Ольга on 19.10.2023.
//

import Foundation
import WebKit

protocol LoginPresenterProtocol: WKNavigationDelegate, WKUIDelegate {
    func getURLRequest() -> URLRequest
    func setView(_ view: LoginViewProtocol)
}

class LoginPresenter: NSObject {
    private var view: LoginViewProtocol?
    private var model: LoginModelProtocol
    
    init(model: LoginModelProtocol) {
        self.model = model
    }

    func getURLRequest() -> URLRequest {
        return URLRequest(url: model.getUrl())
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url {
            let newURL = url.absoluteString.replacingOccurrences(of: "#", with: "?")
            if let token = URL(string: newURL)?.valueOf("access_token") {
                model.setAccessToken(token: token)
                decisionHandler(.cancel)
                view?.didFinish?()
                return
            }
        }
        decisionHandler(.allow)
    }
}

extension LoginPresenter: LoginPresenterProtocol {
    func setView(_ view: LoginViewProtocol) {
        self.view = view
    }
}

extension URL {
    func valueOf(_ queryParameterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else {
            return nil
        }
        return url.queryItems?.first(where: { $0.name == queryParameterName})?.value
    }
}

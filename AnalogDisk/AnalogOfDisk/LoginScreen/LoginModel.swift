//
//  LoginModel.swift
//  AnalogOfDisk
//
//  Created by Ольга on 19.10.2023.
//

import Foundation

protocol LoginModelProtocol {
    func getUrl() -> URL
    func setAccessToken(token: String)
}

class LoginModel {
    var sessionStorage: SessionStorageProtocol
    init(sessionStorage: SessionStorageProtocol) {
        self.sessionStorage = sessionStorage
    }
}

extension LoginModel: LoginModelProtocol {
    func getUrl() -> URL {
        let url = URL(string: "https://oauth.yandex.ru/authorize?response_type=token&client_id=af2611041f8e40bbbfaa679ff174708d")!
        return url
    }
    func setAccessToken(token: String) {
        sessionStorage.accessToken = token
    }
}

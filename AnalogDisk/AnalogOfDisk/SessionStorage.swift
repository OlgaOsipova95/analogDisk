//
//  SessionStorage.swift
//  AnalogOfDisk
//
//  Created by Ольга on 19.10.2023.
//

import Foundation

protocol SessionStorageProtocol {
    var accessToken: String? { get set }
}

class SessionStorage: SessionStorageProtocol {
    private static let accessTokenKey: String = "accessTokenKey"
    var accessToken: String? {
        get {
            UserDefaults.standard.string(forKey: Self.accessTokenKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Self.accessTokenKey)
            NSLog("SessionStorage> setAccessToken = \(String(describing: newValue))")
            UserDefaults.standard.synchronize()
        }
    }
}

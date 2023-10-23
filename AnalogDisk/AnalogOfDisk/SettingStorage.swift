//
//  SettingStorage.swift
//  AnalogOfDisk
//
//  Created by Ольга on 19.10.2023.
//

import Foundation

protocol SettingStorageProtocol {
    var onboardingWasShown: Bool {get set}
}

class SettingStorage: SettingStorageProtocol {
    private static let onboardingWasShownKey: String = "onboardingWasShownKey"
    
    var onboardingWasShown: Bool {
        get {
            UserDefaults.standard.bool(forKey: Self.onboardingWasShownKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Self.onboardingWasShownKey)
            UserDefaults.standard.synchronize()
        }
    }

}

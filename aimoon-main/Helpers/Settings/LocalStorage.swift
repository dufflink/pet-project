//
//  LocalStorage.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 05.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import KeychainAccess

final class LocaleStorage {
    
    let keychain = Keychain()
    let userDefaults = UserDefaults()
    
    // MARK: - Public Properties
    
    var isUserAuth: Bool {
        return accessToken != nil
    }
    
    var accessToken: String? {
        get {
            return keychain.getString(key: .accessToken)
        } set {
            keychain.write(newValue, key: .accessToken)
        }
    }
    
    var mainCategories: [Category]? {
        get {
            return getObject([Category].self, forKey: .mainCategories)
        } set {
            writeObject(newValue, forKey: .mainCategories)
        }
    }
    
    var homeScreen: HomeScreen? {
        get {
            return getObject(HomeScreen.self, forKey: .homeScreen)
        } set {
            writeObject(newValue, forKey: .homeScreen)
        }
    }
    
    var userInfo: UserInfo? {
        get {
            return getObject(UserInfo.self, forKey: .userInfo)
        } set {
            writeObject(newValue, forKey: .userInfo)
        }
    }
    
    // MARK: - Public Functios
    
    func resetLocaleStorage() {
        try? keychain.removeAll()
        
        let userDefaults = UserDefaults()
        userDefaults.dictionaryRepresentation().forEach {
            userDefaults.removeObject(forKey: $0.key)
        }
    }
    
    // MARK: - Private Functions
    
    private func getObject<T: Codable>(_ type: T.Type, forKey key: Key) -> T? {
        return keychain.get(type, forKey: key.rawValue)
    }
    
    private func writeObject<T: Codable>(_ value: T?, forKey key: Key) {
        keychain.write(value, forKey: key.rawValue)
    }
    
    private func getFromKeychain(forKey: Key) -> String? {
        return try? keychain.get(forKey.rawValue)
    }
    
}

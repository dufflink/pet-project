//
//  KeychainAccess.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 05.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import KeychainAccess

extension Keychain {
    
    // MARK: - Public Functions
    
    func getString(key: LocaleStorage.Key) -> String? {
        return try? get(key.rawValue)
    }
    
    func write(_ value: String?, key: LocaleStorage.Key) {
        if let value = value {
            try? set(value, key: key.rawValue)
        } else {
            try? remove(key.rawValue)
        }
    }
    
    func write<T: Codable>(_ value: T?, forKey key: String) {
        if let value = value {
            set(value, forKey: key)
        } else {
            try? remove(key)
        }
    }
    
    func get<T>(_ type: T.Type, forKey key: String) -> T? where T: Codable {
        guard let encodedData = try? getData(key) else {
            return nil
        }
        
        return try? JSONDecoder().decode(type, from: encodedData)
    }
    
    // MARK: - Private Functions
    
    private func set<T: Codable>(_ value: T?, forKey key: String) {
        guard let data = try? JSONEncoder().encode(value) else {
            return
        }
        
        try? set(data, key: key)
    }
    
}

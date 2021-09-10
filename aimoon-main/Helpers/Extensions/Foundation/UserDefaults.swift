//
//  UserDefaults.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 05.09.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    func write(_ value: Any?, forKey key: String) {
        if let value = value {
            set(value, forKey: key)
        } else {
            removeObject(forKey: key)
        }
    }
    
}

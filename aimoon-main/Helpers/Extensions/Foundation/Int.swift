//
//  Int.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 08.02.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

extension Int {
    
    var bool: Bool? {
        if self == 1 {
            return true
        } else if self == 0 {
            return false
        }
        
        return nil
    }
    
}

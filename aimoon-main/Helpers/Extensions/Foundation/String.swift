//
//  String.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 04.04.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

prefix operator §

extension String {
    
    static prefix func § (value: String) -> String {
        let matches = [
            "_": "\u{00A0}",
            "|": "\u{202F}",
            
            "^": "\u{2060}"
        ]
        
        var value = value
        
        for pair in matches {
            value = value.replacingOccurrences(of: pair.key, with: pair.value)
        }
        
        return value
    }
    
}

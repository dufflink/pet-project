//
//  Encodable.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 16.09.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import Foundation

extension Encodable {
    
    func serialized() -> String? {
        let encoder = JSONEncoder()
        
        guard let data = try? encoder.encode(self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
}

//
//  Response.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 18.09.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import Moya

extension Response {
    
    var jsonString: String {
        if let json = try? mapJSON(), let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            return String(data: data, encoding: .utf8) ?? "Parsing: Encoding data to string - error"
        } else {
            if let string = try? mapString() {
                return string
            } else {
                return "Parsing: Response to mapString - error"
            }
        }
    }
    
}

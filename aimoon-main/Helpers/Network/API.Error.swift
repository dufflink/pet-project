//
//  API.Error.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 03.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

extension API {
    
    struct Error: Swift.Error {
        
        var code: Code
        var message: String?
        
        var statusCode: StatusCode
        
    }
    
}

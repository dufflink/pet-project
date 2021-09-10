//
//  MoyaError.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 03.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import Moya

extension MoyaError {
    
    /**
        This parameter displays an error code, which is usually displayed in the console if the request failed
     */
    
    var code: Int? {
        return (self.errorUserInfo["NSUnderlyingError"] as? NSError)?.code
    }
    
    var apiCode: API.Error.Code {
        print("Moya Error code: \(String(describing: code))")
        
        switch code {
            case 13:
                return .connectionFailure
            default:
                return .unknown
        }
    }
    
}

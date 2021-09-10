//
//  OperationResult.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 06.03.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

enum OperationResult {
    
    case success
    case fail(Error)
    
    enum Error {
        
        case serverError(API.Error)
        case fetchingError
        
        case operationInProgress
        case unknown
        
    }
    
}

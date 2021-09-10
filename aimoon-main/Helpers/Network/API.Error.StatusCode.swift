//
//  API.Error.StatusCode.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 03.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

extension API.Error {
    
    enum StatusCode: Int {
        case unknown = 520
        
        case ok = 200
        case created = 201
        
        case accepted = 202
        case noContent = 204
        
        case badRequest = 400
        case unauthorized = 401
        
        case forbidden = 403
        case notFound = 404
        
        case methodNotAllowed = 405
        
        case requestTimeOut = 408
        case unsupportedMediaType = 415
        
        case internalServerError = 500
        case badGateway = 502
        
        case gatewayTimeOut = 504
        case noConnection = 522
    }
    
}

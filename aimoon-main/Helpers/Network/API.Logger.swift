//
//  API.Logger.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 16.09.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import Moya

extension API {
    
    final class Logger {
        
        var logs: [String] = []
        
        // MARK: - Life Cycle
        
        init(method: API.Method) {
            let info = [
                "path": method.path,
                "method": method.method.rawValue
            ]
            
            add("Request: \(info.description)")
            
            switch method.task {
                case .requestParameters(let parameters, _):
                    add("Parameters: \(parameters.description)")
                
                case .requestJSONEncodable(let encodable):
                    if let description = encodable.serialized() {
                        add("Payload: \(description)")
                    }
                
                default:
                    break
            }
        }
        
        // MARK: - Public Functions
        
        func addInfo(from response: Response) {
            add(response.description)
            add(response.jsonString)
        }
        
        func add(_ string: String) {
            logs.append(string)
        }
        
        func printLogs() {
            logs.forEach { print($0) }
        }
        
    }
    
}

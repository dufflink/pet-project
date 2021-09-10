//
//  API.ResponseHandler.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 08.11.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import Moya

extension API {
    
    final class ResponseHandler {
        
        private let jsonDecoder = JSONDecoder()
        private let response: Result<Response, MoyaError>
        
        init(_ response: Result<Response, MoyaError>) {
            self.response = response
        }
        
        func handle<T: Decodable>(_ method: API.Method, with promise: Promise<T>) {
            let logger = Logger(method: method)
            
            switch response {
                case .success(let response):
                    logger.addInfo(from: response)
                    var apiError = API.Error(code: .unknown, message: nil, statusCode: .unknown)
                    
                    if let statusCode = API.Error.StatusCode(rawValue: response.statusCode) {
                        apiError.statusCode = statusCode
                    } else {
                        print("Unknown status code - \(response.statusCode)")
                    }
                    
                    switch response.statusCode {
                        case 200 ..< 300:
                            if let object = try? self.jsonDecoder.decode(T.self, from: response.data) {
                                promise.finish(object)
                            } else {
                                printParsingError(from: response.data, type: T.self)
                                
                                apiError.code = .parsingFailure
                                promise.finish(apiError)
                            }
                        default:
                            if let object = try? self.jsonDecoder.decode(ProcessingError.self, from: response.data) {
                                apiError.message = object.message
                                promise.finish(apiError)
                            } else {
                                printParsingError(from: response.data, type: ProcessingError.self)
                                promise.finish(apiError)
                            }
                    }
                
                case .failure(let error):
                    logger.add(error.errorDescription ?? "Failure error description (nil)")
                    
                    let error = API.Error(code: error.apiCode, message: nil, statusCode: .unknown)
                    promise.finish(error)
            }
            
            logger.printLogs()
        }
        
        // MARK: - Private Functions
        
        private func printParsingError<T: Decodable>(from data: Data, type: T.Type) {
            // TO: Добавить isProduction
            do {
                _ = try self.jsonDecoder.decode(T.self, from: data)
            } catch {
                print(error)
            }
        }
    }
    
}

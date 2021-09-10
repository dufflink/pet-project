//
//  ProcessingError.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 03.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

struct ProcessingError: Decodable, Equatable {
    
    // MARK: - Data Fields
    
    let message: String
//    let code: String?
    
    // MARK: - Keys
    
    enum CodingKeys: String, CodingKey {
        
        case message
//        case code
        
    }
    
}

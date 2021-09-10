//
//  AuthData.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 05.11.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

struct AuthData: Codable {
    
    // MARK: - Data Fields
    
    let accessToken: String
    
    // MARK: - Keys
    
    enum CodingKeys: String, CodingKey {
        
        case accessToken = "access_token"
        
    }
    
}

//
//  UserInfo.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 11.04.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

struct UserInfo: Codable, Equatable {
    
    // MARK: - Data Fields
    
    let name: String
    let surname: String
    
    let email: String
    let phoneNumber: String
    
    // MARK: - Keys
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case surname = "surname"
        
        case email = "email"
        case phoneNumber = "phone"
        
    }
    
}

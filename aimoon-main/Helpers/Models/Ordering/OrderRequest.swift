//
//  OrderRequest.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 12.04.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

struct OrderRequest: Encodable, Equatable {
    
    // MARK: - Data Fields
    
    let userInfo: UserInfo
    let products: [OrderProduct]
    
    // MARK: - Keys
    
    enum CodingKeys: String, CodingKey {
        
        case userInfo = "user"
        case products
        
    }

}

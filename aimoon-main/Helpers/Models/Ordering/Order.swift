//
//  Order.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 13.04.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

struct Order: Codable, Equatable {
    
    // MARK: - Data Fields
    
    let id: Int
    let totalAmount: Int
    
    let status: String
    let statusColor: String
    
    let userName: String?
    let userPhone: String?
    
    let products: [Product]?
    
    // MARK: - Keys
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case totalAmount = "total_amount"
        
        case status = "status_name"
        case statusColor = "status_color"
        
        case userName = "customer_name"
        case userPhone = "customer_phone"
        
        case products
        
    }
    
}

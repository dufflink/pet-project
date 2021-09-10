//
//  OrderProduct.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 12.04.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

struct OrderProduct: Codable, Equatable {
    
    // MARK: - Data Fields
    
    let id: Int
    let quantity: Int
    
    let price: Int
    
    init(product: Product, quantity: Int) {
        self.id = product.id
        self.price = product.price
        
        self.quantity = quantity
    }
    
    // MARK: - Keys
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id_product"
        
        case quantity
        case price
        
    }

}

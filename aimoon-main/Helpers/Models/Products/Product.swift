//
//  Product.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 11.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

struct Product: Codable, Equatable {
    
    // MARK: - Data Fields
    
    let id: Int
    let quantity: Int
    
    let name: String
    let images: [Image]
    
    let price: Int
    let oldPrice: Int?
    
    var isFavorite: Bool?
    var isAddedToCart: Bool?
    
    // MARK: - Keys
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case quantity
        
        case name
        case images = "image"
        
        case price
        case oldPrice = "old_price"
        
        case isFavorite = "is_favorite"
        case isAddedToCart = "is_added_to_cart"
        
    }
    
}

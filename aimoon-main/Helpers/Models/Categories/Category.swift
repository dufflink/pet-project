//
//  Category.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 31.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

struct Category: Codable, Equatable {
    
    // MARK: - Data Fields
    
    let id: Int
    let name: String
    
    let hasSubCategory: Bool
    let iconURL: String?
    
    // MARK: - Keys
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        
        case iconURL = "image_url"
        case hasSubCategory = "sub_category"
        
    }
    
}

//
//  Portion.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 05.09.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

struct Portion<T>: Decodable, Equatable where T: Decodable & Equatable {
    
    // MARK: - Data Fields
    
    let items: [T]
    let metaData: MetaData?
    
    // MARK: -
    
    enum CodingKeys: String, CodingKey {
        
        case items = "data"
        case metaData = "meta"
        
    }
    
}

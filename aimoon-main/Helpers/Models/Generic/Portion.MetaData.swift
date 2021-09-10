//
//  MetaData.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 05.09.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

extension Portion {
    
    struct MetaData: Decodable, Equatable {
        
        let totalCount: Int
        let pageCount: Int
        
        let currentPage: Int
        let perPage: Int?
        
    }
    
}

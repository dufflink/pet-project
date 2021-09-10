//
//  HomeScreen.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 05.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

struct HomeScreen: Codable {
    
    // MARK: - Data Fields
    
    let homeItems: [HomeItem]
    
    // MARK: - Keys
    
    enum CodingKeys: String, CodingKey {
        
        case homeItems = "main_blocks"
        
    }
    
}

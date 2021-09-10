//
//  Image.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 11.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

struct Image: Codable, Equatable {
    
    // MARK: - Data Fields
    
    let url: String
    
    // MARK: - Life Cycle
    
    init(url: String) {
        self.url = url
    }
    
}

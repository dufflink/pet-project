//
//  Banner.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 11.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

struct Banner: Codable {
    
    // MARK: - Data Fields
    
    let route: String?
    let routeParam: Int?
    
    let imageUrl: String?
    
    // MARK: - Keys
    
    enum CodingKeys: String, CodingKey {
        
        case route
        
        case routeParam = "route_param"
        case imageUrl = "image_url"
        
    }
    
}

// MARK: - Banner

extension Banner {
    
    enum Route: String {
        
        init?(route: String?) {
            guard let route = route else {
                return nil
            }
            
            self.init(rawValue: route)
        }
        
        case category
        case favorite
        
        case cart
        case profile
        
        case product
        
    }
    
}

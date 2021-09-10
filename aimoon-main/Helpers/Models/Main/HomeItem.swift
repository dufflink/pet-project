//
//  HomeItem.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 05.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

struct HomeItem: Codable {
    
    // MARK: - Data Fields
    
    let type: String
    let source: String
    
    let label: String?
    let count: Int?
    
    let banners: [Banner]?
    let products: [Product]?
    
}

extension HomeItem {
    
    enum ItemType: String {
        
        case rectangle = "banner_1_3"
        case mosaic = "banner_1_1"
        
        case carousel = "products"
        case viewedProducts = "viewed_products"
        
        var heightOnScreen: CGFloat {
            switch self {
                case .rectangle:
                    return Screen.height / 3.2
                case .mosaic:
                    return Screen.height * 2 / 3.2
                case .carousel, .viewedProducts:
                    return Screen.height / 6
            }
        }
        
    }
    
    enum Source: String {
        
        case network
        case local
        
    }
    
}

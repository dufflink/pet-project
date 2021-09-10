//
//  TabBarSection.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 21.03.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

enum TabBarSection: Int {
    
    init(route: Banner.Route) {
        switch route {
            case .cart:
                self = .cart
            case .favorite:
                self = .favorite
            case .profile:
                self = .profile
            case .category:
                self = .categories
            case .product:
                self = .home
        }
    }
    
    case home
    case categories
    
    case favorite
    case cart
    
    case profile
    
}

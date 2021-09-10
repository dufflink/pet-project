//
//  ProfileMenu.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 09.11.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

enum ProfileMenu: CaseIterable {
    
    case userInfo
    case orders
    
    case aboutApp
    
    // MARK: - Properties
    
    var title: String {
        switch self {
            case .userInfo:
                return "Мои данные"
            case .orders:
                return "Мои заказы"
            case .aboutApp:
                return "О приложении"
        }
    }
    
    var icon: UIImage {
        switch self {
            case .userInfo:
                return #imageLiteral(resourceName: "Profile")
            case .orders:
                return #imageLiteral(resourceName: "Orders")
            case .aboutApp:
                return #imageLiteral(resourceName: "Heart Without Color")
        }
    }
    
}

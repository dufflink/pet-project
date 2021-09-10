//
//  ViewSizes.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 01.10.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

enum ViewSize {
    
    case imageCarousel
    case amNavigationBar
    
    var value: CGFloat {
        switch self {
            case .imageCarousel:
                if Screen.small {
                    return Screen.height * 0.38
                } else if Screen.medium {
                    return Screen.height * 0.34
                } else {
                    return Screen.height * 0.3
                }
            case .amNavigationBar:
                return Screen.safeArea.top + 44
        }
    }
    
}

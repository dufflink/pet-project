//
//  AMNavigationBar.ViewState.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 11.10.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

extension AMNavigationBar {
    
    enum State {
        
        case transparent
        case regular
        
        var barButtonColor: UIColor {
            switch self {
                case .transparent:
                    return #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                case .regular:
                    return #colorLiteral(red: 1, green: 0.3098039216, blue: 0, alpha: 1)
            }
        }
        
    }
    
}

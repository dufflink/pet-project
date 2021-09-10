//
//  AMButtonType.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 09.11.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

enum AMButtonType {
    
    case regular
    case secondary
    
    // MARK: - Properties
    
    var backgroundColor: UIColor {
        switch self {
            case .regular:
                return #colorLiteral(red: 1, green: 0.3098039216, blue: 0, alpha: 1)
            case .secondary:
                return .white
        }
    }
    
    var titleColor: UIColor {
        switch self {
            case .regular:
                return .white
            case .secondary:
                return #colorLiteral(red: 1, green: 0.3098039216, blue: 0, alpha: 1)
        }
    }
    
}

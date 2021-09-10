//
//  Screen.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 15.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

struct Screen {
    
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    static var safeArea: UIEdgeInsets {
        return UIWindow().safeAreaInsets
    }
    
    // MARK: - Screen Sizes
    
    static var small: Bool {
        return height <= 667
    }
    
    static var medium: Bool {
        return height == 736
    }
    
    static var large: Bool {
        return height > 736
    }
    
}

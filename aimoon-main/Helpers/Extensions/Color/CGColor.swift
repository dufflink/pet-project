//
//  CGColor.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 15.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

extension CGColor {
    
    var uiColor: UIColor {
        return UIColor(cgColor: self)
    }
    
}

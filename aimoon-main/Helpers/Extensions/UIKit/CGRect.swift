//
//  CGRect.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 13.07.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

import CoreGraphics

extension CGRect {
    
    func with(x: CGFloat? = nil, y: CGFloat? = nil, width: CGFloat? = nil, height: CGFloat? = nil) -> CGRect {
        return CGRect(x: x ?? minX, y: y ?? minY, width: width ?? self.width, height: height ?? self.height)
    }
    
}

//
//  UIColor.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 17.04.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

import UIKit

extension UIColor {
    
    public convenience init?(hex: String) {
        let r, g, b: CGFloat
        var a: CGFloat = 1
        
        var hex = hex
        
        if hex.hasPrefix("#") {
            hex = String(hex.dropFirst())
        }
        
        if hex.count >= 6 {
            let scanner = Scanner(string: hex)
            var hexNumber: UInt64 = 0

            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                
                if hex.count == 8 {
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                }

                self.init(red: r, green: g, blue: b, alpha: a)
                return
            }
        }
        
        return nil
    }
}

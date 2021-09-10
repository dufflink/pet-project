//
//  UIStackView.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 06.07.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

import UIKit

extension UIStackView {
    
    func clear() {
        subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
}

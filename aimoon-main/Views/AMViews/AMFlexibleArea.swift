//
//  AMFlexibleArea.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 01.11.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

@IBDesignable class AMFlexibleArea: UIView {
    
    private var heightConstraint: NSLayoutConstraint?
    
    // MARK: - Public Properties
    
    var height: CGFloat {
        get {
            return heightConstraint?.constant ?? 0
        } set {
            if let heightConstraint = heightConstraint {
                heightConstraint.constant = newValue
                return
            }
            
            heightConstraint = heightAnchor.constraint(equalToConstant: newValue)
            heightConstraint?.isActive = true
        }
    }
    
}

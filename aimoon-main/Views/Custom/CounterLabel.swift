//
//  CounterLabel.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 25.10.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

final class CounterLabel: UILabel {
    
    private var maxCount: Int = 1
    
    func configure(maxCount: Int, separator: String? = nil) {
        self.maxCount = maxCount
        
        if let separator = separator {
            update(separator: separator)
        } else {
            update()
        }
    }
    
    func update(currentIndex: Int = 1) {
        text = "\(currentIndex)/\(maxCount)"
    }
    
    func update(currentIndex: Int = 1, separator: String) {
        text = "\(currentIndex) \(separator) \(maxCount)"
    }
    
}

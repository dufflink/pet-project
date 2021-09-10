//
//  WithPlaceholder.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 28.03.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

import UIKit

protocol WithPlaceholder: UIViewController {
    
    var placeholder: AMShowableView? { get set }
    
    func showPlaceholder(_ placeholder: AMShowableView)
    
    func hidePlaceholder()
    
}

// MARK: -

extension WithPlaceholder {
    
    func hidePlaceholder() {
        placeholder?.hide()
        placeholder = nil
    }
    
    func showPlaceholder(_ placeholder: AMShowableView) {
        self.placeholder = placeholder
        self.placeholder?.show(in: view)
    }
    
}

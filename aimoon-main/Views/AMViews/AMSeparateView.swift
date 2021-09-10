//
//  AMSeparateView.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 11.10.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

@IBDesignable final class AMSeparateView: AMView {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Private Functions
    
    private func configure() {
        backgroundColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
        heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
    
}

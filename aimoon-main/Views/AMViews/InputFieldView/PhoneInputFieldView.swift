//
//  PhoneInputFieldView.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 11.04.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

import UIKit

final class PhoneInputFieldView: InputFieldView {
    
    override func configure() {
        super.configure()
        textField.shouldCancelPasteAction = true
        setupCountryNumberLabel()
    }
    
    // MARK: - Private Functions
    
    private func setupCountryNumberLabel() {
        textFieldLeading.isActive = false
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "+7"
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: textField.leadingAnchor, constant: 8),
            
            label.widthAnchor.constraint(equalToConstant: textField.frame.height),
            label.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
        ])
    }
    
}

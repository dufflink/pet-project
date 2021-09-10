//
//  InputFieldModel.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 11.04.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

import Foundation

class InputFieldModel {
    
    var title: String
    var validationRules: String
    
    var value: String?
    var maxLenght: Int
    
    // MARK: - Public Properties
    
    var isCorrectValue: Bool {
        guard let value = value, !value.isEmpty, value.count <= maxLenght else {
            return false
        }
        
        let predicate = NSPredicate(format: "SELF MATCHES %@", validationRules)
        return predicate.evaluate(with: value)
    }
    
    // MARK: - Life Cycle
    
    init(title: String, validationRules: String, maxLenght: Int, value: String? = nil) {
        self.title = title
        self.validationRules = validationRules
        
        self.maxLenght = maxLenght
        self.value = value
    }
    
}

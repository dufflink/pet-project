//
//  AMTextField.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 11.04.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

import UIKit

protocol AMTextFieldDelegate: AnyObject {
    
    func deleteButtonDidPress(_ textField: AMTextField)
    
}

final class AMTextField: UITextField {
    
    weak var specificDelegate: AMTextFieldDelegate?
    
    var shouldCancelPasteAction = false
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if shouldCancelPasteAction, selectedTextRange?.start != endOfDocument || action != #selector(paste(_:)) {
            return false
        }
        
        return super.canPerformAction(action, withSender: sender)
    }
    
    override func deleteBackward() {
        super.deleteBackward()
        specificDelegate?.deleteButtonDidPress(self)
    }
    
}

//
//  NSNotification.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 01.11.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

extension NSNotification {
    
    var keyboardSize: CGSize? {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size
    }
    
    var keyboardAnimationDuration: Double? {
        return (userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
    }
    
    var keyboardAnimationCurve: UInt? {
        (userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue
    }
    
}

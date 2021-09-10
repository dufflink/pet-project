//
//  BaseView.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 28.03.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

import UIKit

protocol BaseView: AMViewController {
    
    func showAlert(with title: String, message: String, actionTitle: String, action: (() -> Void)?)
    
    func setNavigationTitle(_ title: String)
    
    func hideKeyboard()
    
}

// MARK: -

extension BaseView {
    
    func showAlert(with title: String, message: String, actionTitle: String, action: (() -> Void)? = nil) {
        showSimpleAlert(with: title, message: message, actionTitle: actionTitle, action: action)
    }
    
    func setNavigationTitle(_ title: String) {
        navigationTitle = title
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
}

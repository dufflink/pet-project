//
//  UIViewController.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 09.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showSimpleAlert(with title: String, message: String, actionTitle: String, action: (() -> Void)? = nil) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default) { _ in
            action?()
        }
        
        controller.addAction(action)
        present(controller, animated: true)
    }
    
    func push(viewController: UIViewController, clearBackStack: Bool = false, hideTabBar: Bool = false, animated: Bool = false) {
        hidesBottomBarWhenPushed = hideTabBar
    
        if !clearBackStack {
            navigationController?.pushViewController(viewController, animated: true)
        } else {
            navigationController?.setViewControllers([viewController], animated: animated)
        }
    }
    
    func popBack() {
        navigationController?.popViewController(animated: true)
    }
    
}

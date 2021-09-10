//
//  UIView.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 15.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

extension UIView {
    
    func addTapperForEndEditing(delegate: UIGestureRecognizerDelegate? = nil) {
        let tapper = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        tapper.cancelsTouchesInView = false

        if let delegate = delegate {
            tapper.delegate = delegate
        }
        
        self.addGestureRecognizer(tapper)
    }
    
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        } set {
            layer.cornerRadius = newValue
        }
    }
    
    func addSubviewAsContent(_ view: UIView, top: CGFloat = 0, bottom: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0, bottomIsLessThanOrEqualTo: Bool = false) {
        view.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(view, at: 0)
        
        let bottomConstraint = bottomIsLessThanOrEqualTo ? view.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: bottom) : view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottom)
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: left),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: right),
            view.topAnchor.constraint(equalTo: topAnchor, constant: top),
            bottomConstraint
        ])
    }
    
}

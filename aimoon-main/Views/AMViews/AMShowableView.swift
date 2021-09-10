//
//  AMShowableView.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 05.09.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

class AMShowableView: AMView {
    
    var isShowing = false
    
    func show(in view: UIView? = nil, bottomView: UIView? = nil) {
        if !isShowing {
            var showingView: UIView
            
            if let view = view {
                showingView = view
            } else {
                guard let window = UIApplication.shared.keyWindow else {
                    return
                }
                
                showingView = window
            }
            
            translatesAutoresizingMaskIntoConstraints = false
            
            showingView.addSubview(self)
            showingView.bringSubviewToFront(self)

            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: showingView.leadingAnchor),
                trailingAnchor.constraint(equalTo: showingView.trailingAnchor),
                topAnchor.constraint(equalTo: showingView.topAnchor),
                bottomAnchor.constraint(equalTo: bottomView?.topAnchor ?? showingView.bottomAnchor)
            ])
            
            isShowing = true
        }
    }

    func hide() {
        if isShowing {
            removeFromSuperview()
            isShowing = false
        }
    }
    
}

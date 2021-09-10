//
//  WithUpdatingView.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 28.03.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

import UIKit

protocol WithUpdatingView: UIViewController {
    
    var updatingView: UpdatingView? { get set }
    
    func updatingViewSetState(isHidden: Bool)
    
}

// MARK: -

extension WithUpdatingView {
    
    func updatingViewSetState(isHidden: Bool) {
        if isHidden {
            updatingView?.hide()
        } else {
            updatingView = UpdatingView()
            updatingView?.show(in: view)
        }
    }
    
}

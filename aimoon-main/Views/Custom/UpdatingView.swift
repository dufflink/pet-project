//
//  UpdatingView.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 05.09.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

final class UpdatingView: AMShowableView {
    
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!

    override func getParentNib() -> UINib? {
        return UINib(resource: R.nib.updatingView)
    }

    // MARK: - Public Functions

    override func show(in view: UIView? = nil, bottomView: UIView? = nil) {
        super.show(in: view, bottomView: bottomView)
        loadingIndicator.startAnimating()
    }

    override func hide() {
        super.hide()
        
        if isShowing {
            loadingIndicator.stopAnimating()
        }
    }
}

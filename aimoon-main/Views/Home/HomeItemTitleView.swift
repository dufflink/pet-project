//
//  HomeItemTitleView.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 15.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

@IBDesignable final class HomeItemTitleView: AMView {
    
    @IBOutlet weak private var titleView: UILabel!
    
    override func getParentNib() -> UINib? {
        return UINib(resource: R.nib.homeItemTitleView)
    }
    
    // MARK: - Public Variables
    
    var text: String? {
        get {
            return titleView.text
        } set {
            titleView.text = newValue
        }
    }
    
}

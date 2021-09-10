//
//  AMTableViewRow.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 09.11.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

class AMTableViewRow: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = R.color.placeholder()?.withAlphaComponent(0.3)
    }
    
}

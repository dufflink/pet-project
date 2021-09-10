//
//  ProfileMenuRow.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 09.11.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

final class ProfileMenuRow: AMTableViewRow {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleView: UILabel!
    
    // MARK: - Public Functions
    
    func configure(from model: ProfileMenu) {
        iconView.image = model.icon
        titleView.text = model.title
    }
    
}

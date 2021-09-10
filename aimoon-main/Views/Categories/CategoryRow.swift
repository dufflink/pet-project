//
//  CategoryRow.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 31.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

final class CategoryRow: AMTableViewRow {
    
    @IBOutlet weak var iconView: UploadableImageView!
    @IBOutlet weak var titleView: UILabel!
    
    @IBOutlet weak var iconViewLeading: NSLayoutConstraint!
    @IBOutlet weak var iconViewWidth: NSLayoutConstraint!
    
    // MARK: - Public Functions
    
    func configure(from model: Category) {
        titleView.text = model.name
        
        if let url = model.iconURL {
            iconViewLeading.constant = 8
            iconViewWidth.constant = 28
            
            iconView.isHidden = false
            iconView.setImage(from: url)
        }
    }
    
}

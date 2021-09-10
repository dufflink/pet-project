//
//  OrderUserInfoView.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 17.04.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

import UIKit

final class OrderUserInfoRowView: AMView {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func getParentNib() -> UINib? {
        return UINib(resource: R.nib.orderUserInfoRowView)
    }
    
    convenience init(title: String, value: String?) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = "\(title):"
        valueLabel.text = value
    }
    
}

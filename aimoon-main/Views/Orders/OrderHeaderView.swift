//
//  OrderHeaderView.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 17.04.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

import UIKit

final class OrderHeaderView: AMView {
    
    @IBOutlet private weak var dateTimeLabel: UILabel!
    
    @IBOutlet private weak var statusView: AMView!
    @IBOutlet private weak var statusLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func getParentNib() -> UINib? {
        return UINib(resource: R.nib.orderHeaderView)
    }
    
    convenience init(order: Order) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        dateTimeLabel.text = ""
        
        statusView.backgroundColor = UIColor(hex: order.statusColor)
        statusLabel.text = order.status
    }
    
}

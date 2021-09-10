//
//  OrderRow.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 13.04.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

import UIKit

final class OrderRow: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!
    
    @IBOutlet private weak var statusIndicator: AMView!
    @IBOutlet private weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = R.color.placeholder()?.withAlphaComponent(0.5)
    }
    
    // MARK: - Public Functions
    
    func configure(from model: Order) {
        titleLabel.text = "Заказ \(model.id)"
        amountLabel.text = §"\(model.totalAmount)|₽"
        
        statusIndicator.backgroundColor = UIColor(hex: model.statusColor)
        statusLabel.text = model.status
    }
    
}

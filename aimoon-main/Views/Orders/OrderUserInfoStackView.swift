//
//  OrderUserInfoStackView.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 17.04.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

import UIKit

final class OrderUserInfoStackView: AMView {
    
    @IBOutlet private weak var stackView: UIStackView!
    
    // MARK: - Life Cycle
    
    override func getParentNib() -> UINib? {
        return UINib(resource: R.nib.orderUserInfoStackView)
    }
    
    convenience init(rows: [OrderUserInfoRowView]) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        
        for row in rows {
            row.heightAnchor.constraint(equalToConstant: 30).isActive = true
            stackView.addArrangedSubview(row)
        }
    }
    
}

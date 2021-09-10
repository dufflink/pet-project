//
//  CartRow.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 03.04.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

import UIKit

protocol CartRowDelegate: AnyObject {
    
    func cartRowRemovingButtonDidPress(at indexPath: IndexPath)
    
}

final class CartRow: UITableViewCell {
    
    @IBOutlet private weak var bodyView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var productImageView: UploadableImageView!
    
    @IBOutlet private weak var removeButton: AMView!
    @IBOutlet private weak var removeButtonIcon: AMImageView!
    
    private var indexPath: IndexPath?
    weak var delegate: CartRowDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = R.color.placeholder()?.withAlphaComponent(0.5)
    }
    
    // MARK: - Public Functions
    
    func configure(from model: Product, needShowRemoveButton: Bool = true, indexPath: IndexPath? = nil, delegate: CartRowDelegate? = nil) {
        self.indexPath = indexPath
        self.delegate = delegate
        
        titleLabel.text = model.name
        priceLabel.text = §"\(model.price)|₽"
        
        if let url = model.images.first?.url {
            productImageView.setImage(from: url)
        }
        
        bodyView.cornerRadius = 8
        productImageView.cornerRadius = 8
        
        if !needShowRemoveButton {
            removeButton.isHidden = true
        } else {
            removeButtonIcon.tintColor = R.color.mainColor()
        }
    }
    
    // MARK: - Builder Functions
    
    @IBAction private func removeButtonDidPress(_ sender: Any) {
        guard let indexPath = indexPath else {
            return
        }
        
        delegate?.cartRowRemovingButtonDidPress(at: indexPath)
    }
    
}

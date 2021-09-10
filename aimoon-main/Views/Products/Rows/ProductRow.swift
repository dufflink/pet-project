//
//  ProductRow.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 25.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

protocol ProductRowDelegate: AnyObject {
    
    func selectableItemDidSelect(at indexPath: IndexPath, isHighlighted: Bool)
    
}

final class ProductRow: UICollectionViewCell {
    
    @IBOutlet weak var bodyView: UIView!
    
    @IBOutlet weak var selectableItemView: SelectableItemView!
    @IBOutlet weak var imageView: UploadableImageView!
    
    @IBOutlet weak var priceView: UILabel!
    @IBOutlet weak var descriptionView: UILabel!
    
    weak var delegate: ProductRowDelegate?
    
    private var indexPath: IndexPath?
    
    // MARK: - Public Functions
    
    func configure(from model: Product, indexPath: IndexPath? = nil, delegate: ProductRowDelegate? = nil, needShowFavoriteItem: Bool = true) {
        if let url = model.images.first?.url {
            imageView.setImage(from: url)
        }
        
        priceView.text = String(model.price)
        descriptionView.text = model.name
        
        if needShowFavoriteItem {
            selectableItemView.set(isHighlighted: model.isFavorite == true)
            selectableItemView.specificDelegate = self
        } else {
            selectableItemView.isHidden = true
        }
        
        imageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        bodyView.cornerRadius = 8
        imageView.cornerRadius = 8
        
        self.indexPath = indexPath
        self.delegate = delegate
    }
    
}

// MARK: - Selectable Item View Delegate

extension ProductRow: SelectableItemViewDelegate {
    
    func selectableItemViewDidPress(isHighlighted: Bool) {
        if let indexPath = indexPath {
            delegate?.selectableItemDidSelect(at: indexPath, isHighlighted: isHighlighted)
        }
    }
    
}

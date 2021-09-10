//
//  SelectableItemView.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 23.11.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

protocol SelectableItemViewDelegate: AnyObject {
    
    func selectableItemViewDidPress(isHighlighted: Bool)
    
}

@IBDesignable final class SelectableItemView: AMView {
    
    @IBInspectable var tintColorView: UIColor?
    @IBOutlet weak var imageView: AMImageView?
    
    @IBInspectable var defaultImage: UIImage?
    @IBInspectable var highlightedImage: UIImage?
    
    weak var specificDelegate: SelectableItemViewDelegate?
    
    // MARK: - Life Cycle
    
    override func getParentNib() -> UINib? {
        return UINib(resource: R.nib.selectableItemView)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView?.image = defaultImage
        imageView?.tintColor = tintColorView
    }
    
    // MARK: - Public Functions
    
    func set(isHighlighted: Bool) {
        self.isHighlighted = isHighlighted
        imageView?.image = isHighlighted ? highlightedImage : defaultImage
    }
    
    // MARK: - IBAction Functions
    
    @IBAction func bodyViewDidPress(_ sender: Any) {
        isHighlighted.toggle()
        imageView?.image = isHighlighted ? highlightedImage : defaultImage
        
        specificDelegate?.selectableItemViewDidPress(isHighlighted: isHighlighted)
    }
    
}

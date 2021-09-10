//
//  AMNavBarButton.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 05.10.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

@IBDesignable final class AMNavBarButton: AMView {
    
    @IBOutlet weak var imageView: AMImageView!
    
    override func getParentNib() -> UINib? {
        return UINib(resource: R.nib.amNavBarButton)
    }
    
    var action: (() -> Void)?
    
    // MARK: - IBAction Functions
    
    @IBAction func bodyViewDidPress(_ sender: Any) {
        action?()
    }
    
    // MARK: - Public Properties
    
    @IBInspectable var image: UIImage? {
        get {
            return imageView.image
        } set {
            imageView.image = newValue
        }
    }
    
    // MARK: - Life Cycle
    
    convenience init(image: UIImage, tintColor: UIColor? = nil, action: (() -> Void)? = nil) {
        self.init()
        imageView.tintColor = tintColor
        imageView.image = image
        
        self.action = action
    }
    
    // MARK: - Public Functions
    
    func setImageTintColor(_ color: UIColor, withAnimation: Bool = false) {
        let setTintColor = {
            self.imageView.tintColor = color
        }
        
        if withAnimation {
            UIView.animate(withDuration: 0.25) {
                setTintColor()
            }
        } else {
            setTintColor()
        }
    }
    
}

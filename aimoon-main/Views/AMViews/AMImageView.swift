//
//  AMImageView.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 19.09.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

@IBDesignable final class AMImageView: UIImageView {
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    override var image: UIImage? {
        get {
            return super.image?.withRenderingMode(.alwaysOriginal)
        } set {
            if #available(iOS 13, *), let tintColor = tintColor {
                super.image = newValue?.withTintColor(tintColor)
            } else {
                super.image = newValue?.withRenderingMode(.alwaysTemplate)
            }
        }
    }
    
    // MARK: - Overriding Properties
    
    override var tintColor: UIColor? {
        didSet {
            image = nil ?? image
        }
    }
    
    // MARK: - Builder Properties
    
    @IBInspectable var isColoring: Bool = false {
        didSet {
            image = nil ?? image
        }
    }
    
    // MARK: - Private Functions
    
    private func configure() {
        backgroundColor = nil
        isColoring = nil ?? isColoring
    }
    
}

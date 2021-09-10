//
//  AMButton.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 07.09.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

@IBDesignable final class AMButton: UIButton {
    
    var type: AMButtonType = .regular {
        didSet {
            configure()
        }
    }
    
    @IBInspectable var isRegular: Bool {
        get {
            return type == .regular
        } set {
            type = newValue ? .regular : .secondary
        }
    }
    
    // MARK: - Properties
    
    var currentBackgroundColor: UIColor? = #colorLiteral(red: 1, green: 0.3098039216, blue: 0, alpha: 1) {
        didSet {
            backgroundColor = currentBackgroundColor
        }
    }
    
    var highlightedBackgroundColor: UIColor? = #colorLiteral(red: 1, green: 0.3098039216, blue: 0, alpha: 1)
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? highlightedBackgroundColor : currentBackgroundColor
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1 : 0.25
        }
    }
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    // MARK: - Public Functions
    
    func setTitle(_ text: String?) {
        setTitle(text?.uppercased(), for: .normal)
    }
    
    func setImage(_ image: UIImage?, withTintColor tintColor: UIColor = .white, for state: UIControl.State) {
        var colorImage: UIImage?
        
        if #available(iOS 13, *) {
            colorImage = image?.withTintColor(tintColor)
        } else {
            colorImage = image?.withRenderingMode(.alwaysTemplate)
            self.tintColor = tintColor
        }
        
        setImage(colorImage, for: state)
    }
    
    // MARK: - Private Functions
    
    private func configure() {
        titleLabel?.font = .boldSystemFont(ofSize: 13)
        cornerRadius = 8
                
        setTitleColor(type.titleColor, for: .normal)
        setTitle(titleLabel?.text)
        
        currentBackgroundColor = type.backgroundColor
        
        if type == .secondary {
            layer.borderWidth = 1
            layer.borderColor = type.titleColor.cgColor
        }
    }
    
}

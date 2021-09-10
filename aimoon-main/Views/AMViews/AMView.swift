//
//  AMView.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 15.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

@IBDesignable class AMView: UIControl {
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibIfAvailable()
        
        viewDidLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibIfAvailable()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewDidLoad()
    }
    
    // MARK: - IBInspectable Properties
    
    @IBInspectable var cornersRadius: CGFloat {
        get {
            return layer.cornerRadius
        } set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            return layer.shadowColor?.uiColor
        } set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowAlpha: Float {
        get {
            return layer.shadowOpacity
        } set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        } set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        } set {
            layer.shadowOffset = newValue
        }
    }
    
    // MARK: - Delegating Functions
    
    func getParentNib() -> UINib? {
        return nil
    }
    
    // MARK: - Public Functions
    
    func viewDidLoad() { }
    
    // MARK: - Private Functions
    
    private func loadNibIfAvailable() {
        guard let rootView = getParentNib()?.instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        
        rootView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(rootView)
        
        NSLayoutConstraint.activate([
            rootView.topAnchor.constraint(equalTo: topAnchor),
            rootView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            rootView.leadingAnchor.constraint(equalTo: leadingAnchor),
            rootView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}

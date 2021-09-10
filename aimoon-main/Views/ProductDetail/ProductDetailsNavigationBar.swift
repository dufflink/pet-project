//
//  ProductDetailsNavigationBar.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 03.02.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

import UIKit

protocol ProductDetailsNavigationBarDelegate: AMNavigationBarDelegate {
    
    func setAsFavoriteButtonDidPress(_ isFavorite: Bool)
    
}

final class ProductDetailsNavigationBar: AMNavigationBar {
    
    private(set) var setAsFavoriteButton: AMNavBarButton!
    private(set) var shareButton: AMNavBarButton!
    
    private var isFavorite = false
    
    weak var specificDelegate: ProductDetailsNavigationBarDelegate?
    
    // MARK: - Life Cycles
    
    convenience init(isFavorite: Bool, shareAction: (() -> Void)?, delegate: ProductDetailsNavigationBarDelegate? = nil, backButtonAction: (() -> Void)?) {
        let setAsFavoriteButton = AMNavBarButton(image: #imageLiteral(resourceName: "Heart Without Color"))
        let shareButton = AMNavBarButton(image: #imageLiteral(resourceName: "Share"))
        
        shareButton.action = shareAction
        
        self.init(barButtons: [setAsFavoriteButton, shareButton], delegate: delegate, backButtonAction: backButtonAction)
        
        setAsFavoriteButton.action = { [weak self] in
            self?.isFavorite.toggle()
            self?.changeHeartButton()
            
            if let isFavorite = self?.isFavorite {
                self?.specificDelegate?.setAsFavoriteButtonDidPress(isFavorite)
            }
        }
        
        self.setAsFavoriteButton = setAsFavoriteButton
        self.shareButton = shareButton
        
        self.isFavorite = isFavorite
        
        changeHeartButton()
        specificDelegate = delegate
        
    }
    
    // MARK: - Public Functions
    
    func setFavoriteState(_ isFavorite: Bool) {
        self.isFavorite = isFavorite
        changeHeartButton()
    }
    
    // MARK: - Private Functions
    
    private func changeHeartButton() {
        let image = isFavorite ? R.image.heartFullFill()! : R.image.heartWithoutColor()!
        setAsFavoriteButton.image = image
    }
    
}

//
//  CarouselBanner.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 23.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

final class CarouselBanner: AMView {
    
    @IBOutlet weak private var headerView: UIView!
    @IBOutlet weak private var titleView: HomeItemTitleView!
    
    @IBOutlet weak var bannersStackView: UIStackView!
    
    override func getParentNib() -> UINib? {
        return UINib(resource: R.nib.carouselBanner)
    }
    
    // MARK: - Life Cycle
    
    convenience init(homeItem: HomeItem, delegate: BannerDelegate?) {
        self.init()
        if let text = homeItem.label {
            titleView.text = text
        } else {
            headerView.isHidden = true
        }
        
        bannersStackView.clear()
        
        homeItem.banners?.forEach {
            let banner = RectangleBanner(banner: $0, delegate: delegate)
            banner.widthAnchor.constraint(equalToConstant: Screen.width - 16).isActive = true
            
            bannersStackView.addArrangedSubview(banner)
        }
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}

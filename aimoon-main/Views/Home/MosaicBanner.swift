//
//  MosaicBanner.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 19.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

final class MosaicBanner: AMView {
    
    @IBOutlet weak private var headerView: UIView!
    @IBOutlet weak private var titleView: HomeItemTitleView!
    
    @IBOutlet weak private var bannersStackView: UIStackView!
    
    override func getParentNib() -> UINib? {
        return UINib(resource: R.nib.mosaicBanner)
    }
    
    // MARK: - Life Cycle
    
    convenience init?(homeItem: HomeItem, delegate: BannerDelegate?) {
        self.init()
        guard let count = homeItem.banners?.count, let banners = homeItem.banners else {
            return nil
        }
        
        if let text = homeItem.label {
            titleView.text = text
        } else {
            headerView.isHidden = true
        }
        
        let viewFactory = HomeItemViewFactory()
        let rectangleBanners = viewFactory.createRectangleBanners(from: banners, delegate: delegate)
        
        var rows = count / 2
        
        if count % 2 == 1 {
            rows += 1
        }
        
        for row in 0 ..< rows {
            let index = row * 2
            let stackView = createStackView()
            
            stackView.addArrangedSubview(rectangleBanners[index])
            let nextIndex = index + 1
            
            if nextIndex < count {
                stackView.addArrangedSubview(rectangleBanners[nextIndex])
            }
            
            bannersStackView.addArrangedSubview(stackView)
        }
    }
    
    // MARK: - Private Functions
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        stackView.alignment = .leading
        stackView.spacing = 0
        
        return stackView
    }
    
}

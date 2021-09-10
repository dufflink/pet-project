//
//  CarouselListBanner.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 23.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

final class CarouselListBanner: AMView {
    
    @IBOutlet weak private var headerView: UIView!
    @IBOutlet weak private var titleView: HomeItemTitleView!
    
    @IBOutlet weak private var collectionView: ProductsCollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    override func getParentNib() -> UINib? {
        return UINib(resource: R.nib.carouselListBanner)
    }
    
    // MARK: - Life Cycle
    
    convenience init(products: [Product], title: String?, delegate: ProductsCollectionViewDelegate?) {
        self.init()
        
        if let title = title {
            titleView.text = title
        } else {
            headerView.isHidden = true
        }

        collectionView.configure(with: products)
        collectionViewHeight.constant = 220

        collectionView.specificDelegate = delegate
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}

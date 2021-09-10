//
//  ImageCarouselView.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 29.09.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

protocol ImageCarouselViewDelegate: AnyObject {
    
    func imageDidSelect()
    
    func currentPageDidChange(_ page: Int)
    
}

@IBDesignable final class ImageCarouselView: AMView {
    
    @IBOutlet weak var collectionView: ImageCarouselCollectionView!
    @IBOutlet weak var counterView: CounterView!
    
    weak var specificDelegate: ImageCarouselViewDelegate?
    
    // MARK: - Life Cycle
    
    override func getParentNib() -> UINib? {
        return UINib(resource: R.nib.imageCarouselView)
    }
    
    convenience init(images: [Image], delegate: ImageCarouselViewDelegate? = nil) {
        self.init()
        specificDelegate = delegate
        translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.configure(with: images, delegate: self)
        counterView.configure(maxCount: images.count)
    }
    
}

// MARK: - Image Carousel Collection View Delegate

extension ImageCarouselView: ImageCarouselCollectionViewDelegate {
    
    func pageDidChange(_ currentPage: Int) {
        counterView.update(currentIndex: currentPage)
        specificDelegate?.currentPageDidChange(currentPage)
    }
    
    func imageDidSelect() {
        specificDelegate?.imageDidSelect()
    }
    
}

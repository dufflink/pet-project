//
//  ImageCarouselCollectionView.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 29.09.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

protocol ImageCarouselCollectionViewDelegate: AnyObject {
    
    func imageDidSelect()
    
    func pageDidChange(_ currentPage: Int)
    
}

final class ImageCarouselCollectionView: UICollectionView {
    
    weak var specificDelegate: ImageCarouselCollectionViewDelegate?
    private var images: [Image] = []
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCollectionView()
    }
    
    // MARK: - Public Properties
    
    var imagesCount: Int {
        return images.count
    }
    
    // MARK: - Public Functions
    
    func configure(with images: [Image], delegate: ImageCarouselCollectionViewDelegate? = nil) {
        self.images = images
        self.specificDelegate = delegate
        
        reloadData()
    }
    
    // MARK: - Private Functions
    
    private func configureCollectionView() {
        dataSource = self
        delegate = self
        
        register(UINib(resource: R.nib.imageRow), forCellWithReuseIdentifier: R.nib.imageRow.identifier)
    }
    
}

// MARK: - UICollectionViewDataSource Functions

extension ImageCarouselCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.imageRow, for: indexPath)
        let image = images[indexPath.row]
        
        row?.configure(from: image)
        return row ?? UICollectionViewCell()
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout Functions

extension ImageCarouselCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        specificDelegate?.imageDidSelect()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bounds.width, height: bounds.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let w = scrollView.bounds.size.width
        
        let currentPage = Int(x / w) + 1
        specificDelegate?.pageDidChange(currentPage)
    }
    
}

//
//  ImageViewerCollectionView.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 18.10.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

protocol ImageViewerCollectionViewDelegate: AnyObject {
    
    func pageDidChange(_ currentPage: Int)
    
}

final class ImageViewerCollectionView: UICollectionView {
    
    weak var specificDelegate: ImageViewerCollectionViewDelegate?
    private var images: [Image] = []
    
    private var widthRow: CGFloat = 0
    private var heightRow: CGFloat = 0
    
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
    
    func configure(with images: [Image]) {
        self.images = images
        reloadData()
    }
    
    // MARK: - Private Functions
    
    private func configureCollectionView() {
        dataSource = self
        delegate = self
        
        register(UINib(resource: R.nib.imageViewerPageRow), forCellWithReuseIdentifier: R.nib.imageViewerPageRow.identifier)
        
        widthRow = Screen.width
        heightRow = Screen.height
    }
    
}

// MARK: - UICollectionViewDataSource Functions

extension ImageViewerCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.imageViewerPageRow, for: indexPath)
        let image = images[indexPath.row]
        
        row?.configure(from: image)
        return row ?? UICollectionViewCell()
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout Functions

extension ImageViewerCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: widthRow, height: heightRow)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let w = scrollView.bounds.size.width
        
        let currentPage = Int(x / w) + 1
        specificDelegate?.pageDidChange(currentPage)
    }
    
}

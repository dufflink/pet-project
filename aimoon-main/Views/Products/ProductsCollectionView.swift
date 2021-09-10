//
//  ProductsCollectionView.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 23.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

protocol ProductsCollectionViewDelegate: AnyObject {
    
    func productDidSelect(_ product: Product)
    
}

final class ProductsCollectionView: UICollectionView {
    
    weak var specificDelegate: ProductsCollectionViewDelegate?
    private var products: [Product] = []
    
    private var widthRow: CGFloat = 0
    private var heightRow: CGFloat = 0
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCollectionView()
        configureFlowLayout(scrollDirection: .horizontal)
    }
    
    // MARK: - Public Properties
    
    var productsCount: Int {
        return products.count
    }
    
    // MARK: - Public Functions
    
    func configure(with products: [Product]) {
        self.products = products
        reloadData()
    }
    
    func configureFlowLayout(scrollDirection: UICollectionView.ScrollDirection) {
        let newCollectionViewLayout = UICollectionViewFlowLayout()
        newCollectionViewLayout.scrollDirection = scrollDirection
        
        if scrollDirection == .horizontal {
            contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            newCollectionViewLayout.minimumInteritemSpacing = 4
        } else {
            contentInset = UIEdgeInsets(top: 2, left: 8, bottom: 8, right: 8)
            
            newCollectionViewLayout.minimumLineSpacing = 8
            newCollectionViewLayout.minimumInteritemSpacing = 2
        }
        
        widthRow = 160
        heightRow = 210
        
        collectionViewLayout = newCollectionViewLayout
    }
    
    // MARK: - Private Functions
    
    private func configureCollectionView() {
        dataSource = self
        delegate = self
        
        register(UINib(resource: R.nib.productRow), forCellWithReuseIdentifier: R.nib.productRow.identifier)
    }
    
}

// MARK: - UICollectionViewDataSource Functions

extension ProductsCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.productRow, for: indexPath)
        let model = products[indexPath.row]
        
        row?.configure(from: model, needShowFavoriteItem: false)
        return row ?? UICollectionViewCell()
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout Functions

extension ProductsCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let product = products[safe: indexPath.row] {
            specificDelegate?.productDidSelect(product)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: widthRow, height: heightRow)
    }
    
}

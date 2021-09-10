//
//  ProductsHeaderView.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 19.09.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

protocol ProductListHeaderViewDelegate: AnyObject {
    
    func sortingButtonDidPress()
    
    func filterButtonDidPress()
    
}

@IBDesignable final class ProductListHeaderView: AMView {
    
    @IBOutlet weak private var filterIconView: AMImageView!
    @IBOutlet weak private var sortingIconView: AMImageView!
    
    weak var delegate: ProductListHeaderViewDelegate?
    
    // MARK: - Life Cycle
    
    override func getParentNib() -> UINib? {
        return UINib(resource: R.nib.productListHeaderView)
    }
    
    convenience init(delegate: ProductListHeaderViewDelegate) {
        self.init()
        self.delegate = delegate
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterIconView.image = #imageLiteral(resourceName: "Filter")
        sortingIconView.image = #imageLiteral(resourceName: "Sorting")
    }
    
    // MARK: - IB Actions
    
    @IBAction func sortingButtonDidPress(_ sender: Any) {
        delegate?.sortingButtonDidPress()
    }
    
    @IBAction func filterButtonDidPress(_ sender: Any) {
        delegate?.filterButtonDidPress()
    }
    
}

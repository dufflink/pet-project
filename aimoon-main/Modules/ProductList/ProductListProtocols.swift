//
//  ProductListProtocols.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 19.11.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import RealmSwift
import UIKit

protocol ProductListViewProtocol: BaseView, WithPlaceholder, WithUpdatingView, WithRefreshControl {
    
    var presenter: ProductListPresenterProtocol? { get set }
    
    var headerView: ProductListHeaderView? { get set }
    
    func updateCollectionView()
    
    func collectionViewSetState(isHidden: Bool)
    
    func configureHeaderView(_ newHeaderView: ProductListHeaderView)
    
    func updateRow(at indexPath: IndexPath)
    
    func removeRow(at indexPath: IndexPath)
    
    func insertRow(at indexPath: IndexPath)
    
}

protocol ProductListPresenterProtocol: AnyObject {
    
    var view: ProductListViewProtocol? { get set }
    
    var products: [Product] { get set }
    
    var favoriteProducts: [Product] { get set }
    
    var productsCount: Int { get }
    
    var placeholderViewFactory: PlaceholderViewFactory { get set }
    
    var nextPage: Int { get }
    
    var hasMorePage: Bool { get set }
    
    var isLoading: Bool { get set }
    
    var needShowFavoriteItem: Bool { get }

    func viewDidLoad()
    
    func didSelectRow(at indexPath: IndexPath)
    
    func scrollViewDidScrollToBottom()
    
    func refreshControllDidBeginRefreshing()
    
}

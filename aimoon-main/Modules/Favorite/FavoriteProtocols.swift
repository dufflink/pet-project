//
//  FavoriteProtocols.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 30.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

protocol FavoriteRouterProtocol: BaseRouter {
    
    static func createModule() -> AMNavigationController
    
    func openProductDetail(from view: BaseView?, product: Product)
    
    func openSortingModule(_ view: BaseView?)
    
    func openFilterModule(_ view: BaseView?)
    
}

protocol FavoritePresenterProtocol: ProductListPresenterProtocol {
    
    var router: FavoriteRouterProtocol? { get set }
    
    init(router: FavoriteRouterProtocol, view: ProductListViewProtocol, interactor: FavoriteInteractorInputProtocol)
    
    var isUserAuth: Bool { get }
    
    func viewDidLoad()
    
}

protocol FavoriteInteractorInputProtocol: AnyObject {
    
    var presenter: FavoriteInteractorOutputProtocol? { get set }
    
    var localStorage: LocaleStorage { get }
    
    var favoriteListManager: FavoriteListManagerInputProtocol? { get }
    
    var productManager: SyncManagerFavoriteProducts? { get set }
    
    func getLocalFavoriteProducts()
    
    func getRemoteFavoriteProducts()
    
    func refreshFavoriteProducts()
    
    func setAsFavorite(product: Product)
    
    func setAsNotFavorite(product: Product)
    
    func setupObserver()
    
    func removeObserver()
    
}

protocol FavoriteInteractorOutputProtocol: AnyObject {
    
    func favoriteProductsDidReceive(_ products: [Product], hasMorePage: Bool)
    
    func gettingRemoteFavoriteProductsDidFinish()
    
    func gettingRemoteFavoriteProductsDidFail(_ error: API.Error?)
    
    func refreshingFavoriteProductsDidFinish()
    
    func refreshingFavoriteProductsDidFail(_ error: API.Error?)
    
    func productDidSetAsFavorite(_ product: Product)
    
    func productDidRemoveFromFavorite(at index: Int)
    
}

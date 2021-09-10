//
//  HomeProtocols.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 09.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

protocol HomeRouterProtocol: BaseRouter {
    
    static func createModule() -> AMNavigationController
    
    func openProductDetail(from view: BaseView?, productID: Int)
    
    func openCategoriesViewController(from view: BaseView?, categoryID: Int)
    
}

protocol HomeViewProtocol: BaseView, WithPlaceholder {
    
    var presenter: HomePresenterProtocol? { get set }
    
    func setupViews(_ views: [UIView])
    
    func stackViewSetState(isHidden: Bool)
    
}

protocol HomePresenterProtocol: AnyObject {
    
    var view: HomeViewProtocol? { get set }
    
    var router: HomeRouterProtocol? { get set }
    
    init(router: HomeRouterProtocol, view: HomeViewProtocol, interactor: HomeInteractorInputProtocol)
    
    var itemsFactory: HomeItemViewFactory { get }
    
    func viewDidLoad()
    
}

protocol HomeInteractorInputProtocol: AnyObject {
    
    var presenter: HomeInteractorOutputProtocol? { get set }
    
    var viewedListManager: ViewedListManagerInputProtocol? { get set }
    
    func getHomeItemModels()
    
    func getViewedProducts(limit: Int?) -> [Product]
    
    func setupObserver()
    
}

protocol HomeInteractorOutputProtocol: AnyObject {
    
    func homeItemsDidReceive(_ items: [HomeItem])
    
    func homeItemsReceivingDidFail()
    
    func viewedProductsDidUpdate()
    
}

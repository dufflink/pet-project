//
//  CartProtocols.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 30.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

protocol CartRouterProtocol: BaseRouter {
    
    static func createModule() -> AMNavigationController
    
    func showOrderingViewController(from view: BaseView?, products: [Product])
    
    func openProductDetail(from view: BaseView?, product: Product)
    
}

protocol CartViewProtocol: BaseView, WithPlaceholder {
    
    var presenter: CartPresenterProtocol? { get set }
    
    func updateTableView()
    
    func setTotalAmountView(value: String)
    
    func setBottomViewState(isHidden: Bool)
    
    func setTableViewState(isHidden: Bool)
    
}

protocol CartPresenterProtocol: AnyObject {
    
    var view: CartViewProtocol? { get set }
    
    var router: CartRouterProtocol? { get set }
    
    init(router: CartRouterProtocol, view: CartViewProtocol, interactor: CartInteractorInputProtocol)
    
    var products: [Product] { get }
    
    func viewDidLoad()
    
    func checkoutButtonDidPress()
    
    func didSelectRow(at indexPath: IndexPath)
    
}

protocol CartInteractorInputProtocol: AnyObject {
    
    var presenter: CartInteractorOutputProtocol? { get set }
    
    var cartListManager: CartListManagerInputProtocol? { get set }
    
    func getCartProducts()
    
    func removeProductFromCart(_ product: Product)
    
    func setupObserver()
    
}

protocol CartInteractorOutputProtocol: AnyObject {
    
    func cartProductsDidReceive(_ products: [Product])
    
}

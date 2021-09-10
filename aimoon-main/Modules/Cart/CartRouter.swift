//
//  CartRouter.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 30.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

final class CartRouter: CartRouterProtocol {
    
    class func createModule() -> AMNavigationController {
        let navigationController = R.storyboard.cart.cartNavigationController()!

        if let view = navigationController.viewControllers.first as? CartViewProtocol {
            let interactor = CartInteractor()
            let cartListManager = CartListManager()
            
            interactor.cartListManager = cartListManager
            cartListManager.output = interactor
            
            let router = CartRouter()
            
            let presenter = CartPresenter(router: router, view: view, interactor: interactor)
            
            view.presenter = presenter
            interactor.presenter = presenter
        }
        
        return navigationController
    }
    
    func showOrderingViewController(from view: BaseView?, products: [Product]) {
        let orderProducts = products.map { OrderProduct(product: $0, quantity: 1) }
        let orderingModel = OrderingRouter.createModule(with: orderProducts)
        
        view?.push(viewController: orderingModel)
    }
    
    func openProductDetail(from view: BaseView?, product: Product) {
        let module = ProductDetailRouter.createModule(productID: product.id)
        view?.push(viewController: module)
    }
    
}

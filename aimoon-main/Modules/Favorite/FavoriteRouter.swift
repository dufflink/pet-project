//
//  FavoriteRouter.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 30.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

final class FavoriteRouter: FavoriteRouterProtocol {
    
    class func createModule() -> AMNavigationController {
        let navigationController = R.storyboard.favorite.favoriteListNavigationController()!

        if let view = navigationController.viewControllers.first as? ProductListViewProtocol {
            let favoriteListManager = FavoriteListManager()
            let interactor = FavoriteInteractor(favoriteListManager: favoriteListManager)
            
            let syncManager = SyncManagerFavoriteProducts()
            interactor.productManager = syncManager
            
            favoriteListManager.output = interactor
            let router = FavoriteRouter()
            
            let presenter = FavoritePresenter(router: router, view: view, interactor: interactor)
            
            view.presenter = presenter
            interactor.presenter = presenter
        }
        
        return navigationController
    }
    
    func openProductDetail(from view: BaseView?, product: Product) {
        let module = ProductDetailRouter.createModule(productID: product.id)
        view?.push(viewController: module)
    }
    
    func openSortingModule(_ view: BaseView?) {
        print("Open sorting module")
    }
    
    func openFilterModule(_ view: BaseView?) {
        print("Open filter module")
    }
    
}

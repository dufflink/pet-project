//
//  HomeRouter.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 09.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

final class HomeRouter: HomeRouterProtocol {
    
    class func createModule() -> AMNavigationController {
        let navigationController = R.storyboard.home.homeNavigationController()!

        if let view = navigationController.viewControllers.first as? HomeViewProtocol {
            let router = HomeRouter()
            let interactor = HomeInteractor()
            
            let viewedListManager = ViewedListManager()
            interactor.viewedListManager = viewedListManager
            
            viewedListManager.output = interactor
            
            let presenter = HomePresenter(router: router, view: view, interactor: interactor)
            interactor.presenter = presenter
            
            view.presenter = presenter
        }

        return navigationController
    }
    
    func openProductDetail(from view: BaseView?, productID: Int) {
        let module = ProductDetailRouter.createModule(productID: productID)
        view?.push(viewController: module)
    }
    
    func openCategoriesViewController(from view: BaseView?, categoryID: Int) {
        let categoryModule = CategoriesRouter.createModuleViewController(categoryID: categoryID)
        categoryModule.hidesBottomBarWhenPushed = true
        
        view?.push(viewController: categoryModule)
    }
    
}

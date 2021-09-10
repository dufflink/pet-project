//
//  CategoriesRouter.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 30.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

final class CategoriesRouter: CategoriesRouterProtocol {
    
    class func createModule() -> AMNavigationController {
        let navigationController = R.storyboard.categories.categoriesNavigationController()!

        if let view = navigationController.viewControllers.first as? CategoriesViewProtocol {
            let router = CategoriesRouter()
            let interactor = CategoriesInteractor()
            
            let presenter = CategoriesPresenter(router: router, view: view, interactor: interactor)
            
            interactor.presenter = presenter
            view.presenter = presenter
        }

        return navigationController
    }
    
    class func createModuleViewController(categoryID: Int) -> AMViewController {
        let categoriesViewController = R.storyboard.categories.categoriesViewController()!
        
        let interactor = CategoriesInteractor(categoryID: categoryID)
        let router = CategoriesRouter()
        
        let presenter = CategoriesPresenter(router: router, view: categoriesViewController, interactor: interactor)
        
        categoriesViewController.presenter = presenter
        interactor.presenter = presenter
        
        return categoriesViewController
    }
    
    func openProductsViewController(from view: BaseView?, category: Category) {
        let productsModule = ProductsRouter.createModule(category: category)
        productsModule.hidesBottomBarWhenPushed = true
        
        view?.push(viewController: productsModule)
    }
    
    func openCategoriesViewController(from view: BaseView?, category: Category) {
        let categoryModule = CategoriesRouter.createModuleViewController(categoryID: category.id)
        categoryModule.hidesBottomBarWhenPushed = true
        
        view?.push(viewController: categoryModule)
    }
    
}

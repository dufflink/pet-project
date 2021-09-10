//
//  ProductsRouter.swift
//  aimoon-main
//

import UIKit

final class ProductsRouter: ProductsRouterProtocol {

    class func createModule(category: Category) -> AMViewController {
        let view = R.storyboard.products.productListViewController()!

        let favoriteListManager = FavoriteListManager()
        
        let interactor = ProductsInteractor(category: category, favoriteListManager: favoriteListManager)
        favoriteListManager.output = interactor
        
        let router = ProductsRouter()
        let presenter = ProductsPresenter(router: router, view: view, interactor: interactor)

        view.presenter = presenter
        interactor.presenter = presenter

        return view
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

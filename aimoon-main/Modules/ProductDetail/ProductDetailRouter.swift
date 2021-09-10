//
//  ProductDetailRouter.swift
//  aimoon-main
//

import UIKit

final class ProductDetailRouter: ProductDetailRouterProtocol {

    class func createModule(productID: Int) -> AMViewController {
        let view = R.storyboard.productDetail.productDetailViewController()!
        let singleProductManager = SingleProductManager(productID: productID)
        
        let interactor = ProductDetailInteractor(productID: productID)
        interactor.singleProductManager = singleProductManager
        
        singleProductManager.output = interactor
        let router = ProductDetailRouter()

        let presenter = ProductDetailPresenter(router: router, view: view, interactor: interactor)

        view.presenter = presenter
        interactor.presenter = presenter

        return view
    }
    
    func openImageViewer(_ view: BaseView?, product: Product) {
        let module = ImageViewerRouter.createModule(product: product)
        module.modalTransitionStyle = .crossDissolve
        module.modalPresentationStyle = .overFullScreen
        
        view?.present(module, animated: true)
    }

}

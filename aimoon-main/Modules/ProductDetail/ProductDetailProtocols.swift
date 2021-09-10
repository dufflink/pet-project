//
//  ProductDetailProtocols.swift
//  aimoon-main
//

import UIKit

protocol ProductDetailRouterProtocol: BaseRouter {

    static func createModule(productID: Int) -> AMViewController
    
    func openImageViewer(_ view: BaseView?, product: Product)
    
}

protocol ProductDetailViewProtocol: BaseView, WithUpdatingView, WithPlaceholder {

    var presenter: ProductDetailPresenterProtocol? { get set }
    
    var statusBarStyle: UIStatusBarStyle { get set }
    
    var amNavigationBar: ProductDetailsNavigationBar? { get set }
    
    func updateTtileView(text: String)
    
    func updatePriceView(value: String)
    
    func updateAddToCartButton(text: String, color: UIColor?)
    
    func setNavigationBar(_ navigationBar: ProductDetailsNavigationBar)
    
    func setStatusBarStyle(_ style: UIStatusBarStyle)
    
    func setImageCarouselView(_ view: UIView)
    
    func setNavBarState(isHidden: Bool)
    
    func setNavBarState(isFavorite: Bool)
    
    func share(items: [Any])
    
    func mainViewsSetState(isHidden: Bool)

}

protocol ProductDetailPresenterProtocol: AnyObject {

    var view: ProductDetailViewProtocol? { get set }

    var interactor: ProductDetailInteractorInputProtocol? { get set }

    var router: ProductDetailRouterProtocol? { get set }

    init(router: ProductDetailRouterProtocol, view: ProductDetailViewProtocol, interactor: ProductDetailInteractorInputProtocol)

    var product: Product? { get }
    
    var currentImageCarouselPage: Int { get set }
    
    func viewDidLoad()
    
    func addToCartButtonDidPress()

}

protocol ProductDetailInteractorInputProtocol: AnyObject {
    
    var presenter: ProductDetailInteractorOutputProtocol? { get set }
    
    var product: Product? { get }
    
    var productID: Int { get }
    
    var singleProductManager: SingleProductManagerInputProtocol? { get set }
    
    var localStorage: LocaleStorage { get }
    
    init(productID: Int)
    
    func getProduct()
    
    func addProductToCart()
    
    func getImageData(index: Int)
    
    func setAsFavorite()
    
    func setAsNotFavorite()
    
    func setAsViewed()
    
    func setupObserver()
    
}

protocol ProductDetailInteractorOutputProtocol: AnyObject {
    
    func productDidReceive(_ product: Product)
    
    func productReceivingDidFail(_ error: API.Error?)
    
    func imageDataDidReceive(image: UIImage)
    
    func imageDataReceivingDidFail()
    
    func productFavoriteStateDidChange(_ isFavorite: Bool)
    
    func productCartStateDidChange(_ isAddedToCart: Bool)
    
}

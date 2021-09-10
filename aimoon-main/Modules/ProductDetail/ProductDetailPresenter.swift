//
//  ProductDetailPresenter.swift
//  aimoon-main
//

import UIKit

final class ProductDetailPresenter: ProductDetailPresenterProtocol {

    weak var view: ProductDetailViewProtocol?

    var interactor: ProductDetailInteractorInputProtocol?
    var router: ProductDetailRouterProtocol?
    
    var product: Product?
    var currentImageCarouselPage: Int = 1

    // MARK: - Life Cycle

    init(router: ProductDetailRouterProtocol, view: ProductDetailViewProtocol, interactor: ProductDetailInteractorInputProtocol) {
        self.router = router
        self.view = view

        self.interactor = interactor
    }
    
    // MARK: - Public Functions
    
    func addToCartButtonDidPress() {
        if product?.isAddedToCart == true {
            Events.shared.report(.toCartButtonDidPress)
        } else {
            interactor?.addProductToCart()
        }
    }

    func viewDidLoad() {
        reloadData()
    }
    
    // MARK: - Private Functions
    
    private func reloadData() {
        view?.mainViewsSetState(isHidden: true)
        view?.updatingViewSetState(isHidden: false)
        
        view?.hidePlaceholder()
        interactor?.getProduct()
    }
    
    private func configureNavigationBar() {
        let isFavorite = product?.isFavorite ?? false
        
        let shareAction = { [weak self] in
            let index = self?.currentImageCarouselPage ?? 1
            self?.interactor?.getImageData(index: index)
        }
        
        let navigationBar = ProductDetailsNavigationBar(isFavorite: isFavorite, shareAction: shareAction, delegate: self) { [weak self] in
            self?.view?.setNavBarState(isHidden: false)
            self?.router?.popViewController(self?.view)
        }
        
        view?.setNavigationBar(navigationBar)
    }
    
    private func setCartButtonState() {
        let text = "Перейти в корзину"
        let color = R.color.placeholder()
        
        view?.updateAddToCartButton(text: text, color: color)
    }

}

// MARK: - ProductDetail Interactor Output Protocol

extension ProductDetailPresenter: ProductDetailInteractorOutputProtocol {
    
    func productDidReceive(_ product: Product) {
        self.product = product
        
        let images = product.images
        let imageCarouselView = ImageCarouselView(images: images, delegate: self)
        
        view?.setImageCarouselView(imageCarouselView)
        
        let name = product.name
        let price = "\(product.price) ₽"
        
        view?.updateTtileView(text: name)
        view?.updatePriceView(value: price)
        
        interactor?.setupObserver()
        
        configureNavigationBar()
        interactor?.setAsViewed()
        
        view?.updatingViewSetState(isHidden: true)
        view?.mainViewsSetState(isHidden: false)
        
        if product.isAddedToCart == true {
            setCartButtonState()
        }
    }
    
    func productReceivingDidFail(_ error: API.Error?) {
        view?.updatingViewSetState(isHidden: true)
        view?.mainViewsSetState(isHidden: true)
        
        view?.hidePlaceholder()
        
        let placeholder = PlaceholderViewFactory().createPlaceholder(context: .loadingProductDidFail, delegate: self)
        view?.showPlaceholder(placeholder)
    }
    
    func imageDataDidReceive(image: UIImage) {
        if let product = product {
            let items: [Any] = [image, product.name, product.price]
            view?.share(items: items)
        }
    }
    
    func imageDataReceivingDidFail() {
        view?.showAlert(with: "Упс", message: "Что-то пошло не так", actionTitle: "Закрыть")
    }
    
    func productFavoriteStateDidChange(_ isFavorite: Bool) {
        view?.setNavBarState(isFavorite: isFavorite)
    }
    
    func productCartStateDidChange(_ isAddedToCart: Bool) {
        product?.isAddedToCart = isAddedToCart
        
        if isAddedToCart {
            setCartButtonState()
        }
    }
    
}

// MARK: - AMNavigation Bar Delegate

extension ProductDetailPresenter: ProductDetailsNavigationBarDelegate {
    
    func stateDidChange(_ currentState: AMNavigationBar.State) {
        let statusBarStyle: UIStatusBarStyle = currentState == .regular ? .default : .lightContent
        view?.setStatusBarStyle(statusBarStyle)
    }
    
    func setAsFavoriteButtonDidPress(_ isFavorite: Bool) {
        isFavorite ? interactor?.setAsFavorite() : interactor?.setAsNotFavorite()
    }
    
}

// MARK: - Image Carousel View Delegate

extension ProductDetailPresenter: ImageCarouselViewDelegate {
    
    func currentPageDidChange(_ page: Int) {
        currentImageCarouselPage = page
    }
    
    func imageDidSelect() {
        if let product = product, !product.images.isEmpty {
            router?.openImageViewer(view, product: product)
        }
    }
    
}

// MARK: - Placeholder Delegate

extension ProductDetailPresenter: PlaceholderDelegate {
    
    func actionButtonDidPress(_ context: PlaceholderViewFactory.Context) {
        if case .loadingProductDidFail = context {
            reloadData()
        }
    }
    
}

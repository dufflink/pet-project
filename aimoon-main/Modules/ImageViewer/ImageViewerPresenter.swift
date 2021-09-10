//
//  ImageViewerPresenter.swift
//  aimoon-main
//

import UIKit

final class ImageViewerPresenter: ImageViewerPresenterProtocol {
    
    weak var view: ImageViewerViewProtocol?

    var interactor: ImageViewerInteractorInputProtocol?
    var router: ImageViewerRouterProtocol?
    
    var product: Product? {
        return interactor?.product
    }
    
    var currentPage: Int = 1

    // MARK: - Life Cycle
    
    init(router: ImageViewerRouterProtocol, view: ImageViewerViewProtocol, interactor: ImageViewerInteractorInputProtocol) {
        self.router = router
        self.view = view

        self.interactor = interactor
    }

    func viewDidAppear() {
        configureNavigationBar()
        configureImageViewer()
    }

}

// MARK: - Private Functions

extension ImageViewerPresenter {
    
    private func configureNavigationBar() {
        let shareButton = AMNavBarButton(image: #imageLiteral(resourceName: "Share")) { [weak self] in
            self?.interactor?.getImageData(index: self?.currentPage ?? 1)
        }
        
        let navigationBar = AMNavigationBar(barButtons: [shareButton], backButtonImage: #imageLiteral(resourceName: "Close")) { [weak self] in
            self?.router?.dismissViewController(self?.view, withAnimation: true)
        }
        
        view?.setNavigationBar(navigationBar)
    }
    
    private func configureImageViewer() {
        guard let product = product else {
            view?.showAlert(with: "Ошибка", message: "Не удалось загрузить изображения для просмотра", actionTitle: "Вернуться назад") { [weak self] in
                if let view = self?.view {
                    self?.router?.dismissViewController(view, withAnimation: true)
                }
            }

            return
        }
        
        let imageViewer = ImageViewer(product: product, delegate: self)
        view?.setImageViewer(imageViewer)
    }
    
}

// MARK: - ImageViewer Interactor Output Protocol

extension ImageViewerPresenter: ImageViewerInteractorOutputProtocol {
    
    func imageDataDidReceive(image: UIImage) {
        view?.share(image: image)
    }
    
    func imageDataReceivingDidFail() {
        view?.showAlert(with: "Упс", message: "Что-то пошло не так", actionTitle: "Закрыть")
    }
    
}

// MARK: - Image Viewer Delegate

extension ImageViewerPresenter: ImageViewerDelegate {
    
    func currentPageDidChange(_ page: Int) {
        currentPage = page
    }
    
    func imageViewerDidChangeAlpha(_ alpha: CGFloat) {
        view?.setAlpha(alpha)
    }
    
    func needDismiss() {
        router?.dismissViewController(view, withAnimation: false)
    }
    
}

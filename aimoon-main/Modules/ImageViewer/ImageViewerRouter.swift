//
//  ImageViewerRouter.swift
//  aimoon-main
//

import UIKit

final class ImageViewerRouter: ImageViewerRouterProtocol {

    class func createModule(product: Product) -> AMViewController {
        let view = R.storyboard.imageViewer.imageViewerViewController()!

        let interactor = ImageViewerInteractor(product: product)
        let router = ImageViewerRouter()

        let presenter = ImageViewerPresenter(router: router, view: view, interactor: interactor)

        view.presenter = presenter
        interactor.presenter = presenter

        return view
    }
    
    func dismissViewController(_ view: BaseView?, withAnimation: Bool) {
        view?.dismiss(animated: withAnimation)
    }

}

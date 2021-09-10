//
//  ImageViewerProtocols.swift
//  aimoon-main
//

import UIKit

protocol ImageViewerRouterProtocol: BaseRouter {

    static func createModule(product: Product) -> AMViewController
    
    func dismissViewController(_ view: BaseView?, withAnimation: Bool)
    
}

protocol ImageViewerViewProtocol: BaseView {

    var presenter: ImageViewerPresenterProtocol? { get set }
    
    func setNavigationBar(_ navigationBar: AMNavigationBar)
    
    func setImageViewer(_ imageViewer: UIView)
    
    func share(image: UIImage)
    
    func setAlpha(_ alpha: CGFloat)

}

protocol ImageViewerPresenterProtocol: AnyObject {

    var view: ImageViewerViewProtocol? { get set }

    var interactor: ImageViewerInteractorInputProtocol? { get set }

    var router: ImageViewerRouterProtocol? { get set }

    init(router: ImageViewerRouterProtocol, view: ImageViewerViewProtocol, interactor: ImageViewerInteractorInputProtocol)

    var product: Product? { get }
    
    var currentPage: Int { get set }
    
    func viewDidAppear()

}

protocol ImageViewerInteractorInputProtocol: AnyObject {

    var presenter: ImageViewerInteractorOutputProtocol? { get set }
    
    var product: Product { get }
    
    init(product: Product)
    
    func getImageData(index: Int)

}

protocol ImageViewerInteractorOutputProtocol: AnyObject {
    
    func imageDataDidReceive(image: UIImage)
    
    func imageDataReceivingDidFail()
    
}

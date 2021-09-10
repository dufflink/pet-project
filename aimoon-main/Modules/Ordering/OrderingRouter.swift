//
//  OrderingRouter.swift
//  aimoon-main
//

final class OrderingRouter: OrderingRouterProtocol {

    class func createModule(with products: [OrderProduct]) -> AMViewController {
        let view = R.storyboard.ordering.orderingViewController()!

        let interactor = OrderingInteractor(products: products)
        let router = OrderingRouter()

        let presenter = OrderingPresenter(router: router, view: view, interactor: interactor)

        view.presenter = presenter
        interactor.presenter = presenter

        return view
    }

    func showSeccessOrderingViewController(from view: BaseView?) {
        let successOrderingViewController = SuccessOrderingRouter.createModule()
        successOrderingViewController.modalPresentationStyle = .fullScreen
        
        view?.present(successOrderingViewController, animated: true)
    }
    
}

//
//  OrderListRouter.swift
//  aimoon-main
//

final class OrderListRouter: OrderListRouterProtocol {

    // MARK: - Life Cycle
    
    class func createModule() -> AMViewController {
        let view = R.storyboard.orderList.orderListViewController()!

        let interactor = OrderListInteractor()
        let router = OrderListRouter()

        let presenter = OrderListPresenter(router: router, view: view, interactor: interactor)

        view.presenter = presenter
        interactor.presenter = presenter

        return view
    }
    
    // MARK: - Functions
    
    func openOrderDetailViewController(from view: BaseView?, order: Order) {
        let orderDetailModule = OrderDetailRouter.createModule(order)
        view?.push(viewController: orderDetailModule)
    }

}

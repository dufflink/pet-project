//
//  OrderDetailRouter.swift
//  aimoon-main
//

final class OrderDetailRouter: OrderDetailRouterProtocol {

    // MARK: - Life Cycle
    
    class func createModule(_ order: Order) -> AMViewController {
        let view = R.storyboard.orderDetail.orderDetailViewController()!

        let interactor = OrderDetailInteractor(orderID: order.id)
        let router = OrderDetailRouter()

        let presenter = OrderDetailPresenter(router: router, view: view, interactor: interactor)

        view.presenter = presenter
        interactor.presenter = presenter

        return view
    }
    
    // MARK: - Functions
    
    func openProductDetail(from view: BaseView?, product: Product) {
        let module = ProductDetailRouter.createModule(productID: product.id)
        view?.push(viewController: module)
    }

}

//
//  OrderDetailPresenter.swift
//  aimoon-main
//

import UIKit

final class OrderDetailPresenter: OrderDetailPresenterProtocol {

    weak var view: OrderDetailViewProtocol?

    var interactor: OrderDetailInteractorInputProtocol?
    var router: OrderDetailRouterProtocol?
    
    var order: Order?

    // MARK: - Life Cycle

    init(router: OrderDetailRouterProtocol, view: OrderDetailViewProtocol, interactor: OrderDetailInteractorInputProtocol) {
        self.router = router
        self.view = view

        self.interactor = interactor
    }

    func viewDidLoad() {
        if let id = interactor?.orderID {
            view?.setNavigationTitle("Заказ \(id)")
        }
        
        reloadData()
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        if let product = order?.products?[safe: indexPath.row] {
            router?.openProductDetail(from: view, product: product)
        }
    }
    
    private func reloadData() {
        view?.viewsSetState(isHidden: true)
        view?.updatingViewSetState(isHidden: false)
        
        view?.hidePlaceholder()
        interactor?.getOrderInfo()
    }

}

// MARK: - OrderDetail Interactor Output Protocol

extension OrderDetailPresenter: OrderDetailInteractorOutputProtocol {
    
    func orderInfoDidReceive(_ order: Order) {
        self.order = order
        
        view?.viewsSetState(isHidden: false)
        view?.updatingViewSetState(isHidden: true)
        
        view?.updateTableView()
        
        let userInfoRows: [OrderUserInfoRowView] = [
            .init(title: "Получатель", value: order.userName),
            .init(title: "Номер телефона", value: order.userPhone)
        ]
        
        let userInfoView = OrderUserInfoStackView(rows: userInfoRows)
        view?.setUserInfoView(userInfoView)
        
        let headerView = OrderHeaderView(order: order)
        headerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view?.setHeaderView(headerView)
    }
    
    func orderInfoReceivingDidFail(_ error: API.Error) {
        view?.updatingViewSetState(isHidden: true)
        view?.viewsSetState(isHidden: true)
        
        view?.hidePlaceholder()
        
        let placeholder = PlaceholderViewFactory().createPlaceholder(context: .loadingOrderDidFail, delegate: self)
        view?.showPlaceholder(placeholder)
    }
    
}

// MARK: - Placeholder Delegate

extension OrderDetailPresenter: PlaceholderDelegate {
    
    func actionButtonDidPress(_ context: PlaceholderViewFactory.Context) {
        if case .loadingOrderDidFail = context {
            reloadData()
        }
    }
    
}

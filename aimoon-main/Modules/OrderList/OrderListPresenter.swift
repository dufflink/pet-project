//
//  OrderListPresenter.swift
//  aimoon-main
//

import UIKit

final class OrderListPresenter: OrderListPresenterProtocol {

    weak var view: OrderListViewProtocol?

    var interactor: OrderListInteractorInputProtocol?
    var router: OrderListRouterProtocol?
    
    var placeholderViewFactory: PlaceholderViewFactory
    var orders: [Order] = []
    
    var isLoading = false
    
    var hasMorePage = false
    var nextPage = 1

    // MARK: - Life Cycle

    init(router: OrderListRouterProtocol, view: OrderListViewProtocol, interactor: OrderListInteractorInputProtocol) {
        self.router = router
        self.view = view

        self.interactor = interactor
        placeholderViewFactory = PlaceholderViewFactory()
    }
    
    // MARK: - Functions

    func viewDidLoad() {
        view?.setNavigationTitle("Мои заказы")
        view?.setRefreshControl()
        
        view?.updatingViewSetState(isHidden: false)
        view?.tableViewSetState(isHidden: true)
        
        interactor?.getOrderList(page: nextPage)
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard let order = orders[safe: indexPath.row] else {
            return
        }
        
        router?.openOrderDetailViewController(from: view, order: order)
    }
    
    func scrollViewDidScrollToBottom() {
        nextPage += 1
        
        isLoading = true
        interactor?.getOrderList(page: nextPage)
    }
    
    func refreshControllDidBeginRefreshing() {
        isLoading = true
        
        nextPage = 1
        interactor?.refreshOrderList()
    }

}

// MARK: - OrderList Interactor Output Protocol

extension OrderListPresenter: OrderListInteractorOutputProtocol {
    
    func orderListDidRecieve(_ orders: [Order], hasMorePage: Bool) {
        view?.updatingViewSetState(isHidden: true)
        
        if orders.isEmpty {
            if nextPage == 1 {
                let placeholder = placeholderViewFactory.createPlaceholder(context: .orderListIsEmpty, delegate: self)
                view?.showPlaceholder(placeholder)
                
                view?.tableViewSetState(isHidden: true)
                view?.setTableViewFooter(isHidden: true)
            }
        } else {
            self.orders += orders
            self.hasMorePage = hasMorePage
            
            view?.setTableViewFooter(isHidden: !hasMorePage)
            view?.tableViewSetState(isHidden: false)
            
            view?.hidePlaceholder()
            view?.updateTableView()
        }
        
        isLoading = false
    }
    
    func orderListReceivingDidFail(_ error: API.Error?) {
        if nextPage == 1 {
            let action = {
                if let view = self.view {
                    self.router?.popViewController(view)
                }
            }
            
            view?.showAlert(with: "Ошибка", message: "Не удалось загрузить данные", actionTitle: "Вернуться", action: action)
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                self?.interactor?.getOrderList(page: self?.nextPage)
            }
        }
    }
    
    func orderListRefreshingDidFinish(_ orders: [Order], hasMorePage: Bool) {
        if orders.isEmpty {
            if nextPage == 1 {
                let placeholder = placeholderViewFactory.createPlaceholder(context: .orderListIsEmpty, delegate: self)
                view?.showPlaceholder(placeholder)
                
                view?.setTableViewFooter(isHidden: true)
                view?.tableViewSetState(isHidden: true)
            }
        } else {
            self.orders = orders
            self.hasMorePage = hasMorePage
            
            view?.setTableViewFooter(isHidden: !hasMorePage)
            view?.tableViewSetState(isHidden: false)
            
            view?.stopRefreshing()
            view?.updateTableView()
        }
        
        isLoading = false
    }
    
    func orderListRefreshingDidFail(_ error: API.Error?) {
        view?.stopRefreshing()
        
        isLoading = false
        view?.showAlert(with: "Ошибка", message: "Не удалось обновить список заказов", actionTitle: "ОК")
    }
    
}

// MARK: - Placeholder Delegate

extension OrderListPresenter: PlaceholderDelegate {
    
    func actionButtonDidPress(_ context: PlaceholderViewFactory.Context) {
        if case .orderListIsEmpty = context {
            Events.shared.report(.toCategoryButtonDidPress)
            router?.popViewController(view)
        }
    }
    
}

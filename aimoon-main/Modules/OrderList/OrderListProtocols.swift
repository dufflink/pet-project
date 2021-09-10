//
//  OrderListProtocols.swift
//  aimoon-main
//

import UIKit

protocol OrderListRouterProtocol: BaseRouter {

    static func createModule() -> AMViewController
    
    func openOrderDetailViewController(from view: BaseView?, order: Order)
    
}

protocol OrderListViewProtocol: BaseView, WithPlaceholder, WithUpdatingView, WithRefreshControl {

    var presenter: OrderListPresenterProtocol? { get set }
    
    func tableViewSetState(isHidden: Bool)
    
    func updateTableView()
    
    func setTableViewFooter(isHidden: Bool)

}

protocol OrderListPresenterProtocol: AnyObject {

    var view: OrderListViewProtocol? { get set }

    var interactor: OrderListInteractorInputProtocol? { get set }

    var router: OrderListRouterProtocol? { get set }

    init(router: OrderListRouterProtocol, view: OrderListViewProtocol, interactor: OrderListInteractorInputProtocol)

    func viewDidLoad()
    
    func didSelectRow(at indexPath: IndexPath)
    
    var orders: [Order] { get set }
    
    var placeholderViewFactory: PlaceholderViewFactory { get set }
    
    var nextPage: Int { get }
    
    var hasMorePage: Bool { get set }
    
    var isLoading: Bool { get set }
    
    func scrollViewDidScrollToBottom()
    
    func refreshControllDidBeginRefreshing()

}

protocol OrderListInteractorInputProtocol: AnyObject {

    var presenter: OrderListInteractorOutputProtocol? { get set }
    
    func getOrderList(page: Int?)
    
    func refreshOrderList()

}

protocol OrderListInteractorOutputProtocol: AnyObject {
    
    func orderListDidRecieve(_ orders: [Order], hasMorePage: Bool)
    
    func orderListReceivingDidFail(_ error: API.Error?)
    
    func orderListRefreshingDidFinish(_ orders: [Order], hasMorePage: Bool)
    
    func orderListRefreshingDidFail(_ error: API.Error?)
    
}

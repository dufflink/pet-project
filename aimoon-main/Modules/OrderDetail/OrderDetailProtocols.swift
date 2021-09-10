//
//  OrderDetailProtocols.swift
//  aimoon-main
//

import UIKit

protocol OrderDetailRouterProtocol: BaseRouter {

    static func createModule(_ order: Order) -> AMViewController
    
    func openProductDetail(from view: BaseView?, product: Product)
    
}

protocol OrderDetailViewProtocol: BaseView, WithPlaceholder, WithUpdatingView {

    var presenter: OrderDetailPresenterProtocol? { get set }
    
    var userInfoView: OrderUserInfoStackView? { get }
    
    func updateTableView()
    
    func setHeaderView(_ headerView: UIView) // set header
    
    func setUserInfoView(_ userInfoView: OrderUserInfoStackView) // set user info view
    
    func viewsSetState(isHidden: Bool)

}

protocol OrderDetailPresenterProtocol: AnyObject {

    var view: OrderDetailViewProtocol? { get set }

    var interactor: OrderDetailInteractorInputProtocol? { get set }

    var router: OrderDetailRouterProtocol? { get set }
    
    var order: Order? { get }

    init(router: OrderDetailRouterProtocol, view: OrderDetailViewProtocol, interactor: OrderDetailInteractorInputProtocol)

    func viewDidLoad()
    
    func didSelectRow(at indexPath: IndexPath)

}

protocol OrderDetailInteractorInputProtocol: AnyObject {

    var presenter: OrderDetailInteractorOutputProtocol? { get set }
    
    var orderID: Int { get }
    
    init(orderID: Int)
    
    func getOrderInfo()

}

protocol OrderDetailInteractorOutputProtocol: AnyObject {
    
    func orderInfoDidReceive(_ order: Order)
    
    func orderInfoReceivingDidFail(_ error: API.Error)
    
}

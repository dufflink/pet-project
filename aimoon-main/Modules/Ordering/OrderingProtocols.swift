//
//  OrderingProtocols.swift
//  aimoon-main
//

import UIKit

protocol OrderingRouterProtocol: BaseRouter {

    static func createModule(with products: [OrderProduct]) -> AMViewController
    
    func showSeccessOrderingViewController(from view: BaseView?)
    
}

protocol OrderingViewProtocol: BaseView {

    var presenter: OrderingPresenterProtocol? { get set }
    
    func setAcceptOrderButtonState(isEnabled: Bool)
    
    func setAcceptOrderButtonColor(_ color: UIColor?)
    
    func setAcceptOrderButtonState(isHidden: Bool)
    
    func setupInputFields(_ inputFields: [InputFieldView])
    
    func setActivityIndicatorState(isHidden: Bool)

}

protocol OrderingPresenterProtocol: AnyObject {

    var view: OrderingViewProtocol? { get set }

    var interactor: OrderingInteractorInputProtocol? { get set }

    var router: OrderingRouterProtocol? { get set }

    init(router: OrderingRouterProtocol, view: OrderingViewProtocol, interactor: OrderingInteractorInputProtocol)

    func viewDidLoad()
    
    func acceptOrderButtonDidPress()
    
    func setupInputViewFields(_ userInfo: UserInfo?)
    
    var inputViewFields: [InputFieldView]? { get }

}

protocol OrderingInteractorInputProtocol: AnyObject {

    var presenter: OrderingInteractorOutputProtocol? { get set }
    
    var localStorage: LocaleStorage { get }
    
    var productManager: ProductManager { get }
    
    var products: [OrderProduct] { get }
    
    init(products: [OrderProduct])
    
    func getUserInfo()
    
    func createOrder(userInfo: UserInfo)

}

protocol OrderingInteractorOutputProtocol: AnyObject {
    
    func orderingCreatinDidStart()
    
    func orderDidCreate()
    
    func orderCreatingDidFail(_ error: API.Error)
    
    func userInfoDidReceive(_ userInfo: UserInfo?)
    
}

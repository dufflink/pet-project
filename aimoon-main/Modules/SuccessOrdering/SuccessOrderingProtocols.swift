//
//  SuccessOrderingProtocols.swift
//  aimoon-main
//

protocol SuccessOrderingRouterProtocol: BaseRouter {

    static func createModule() -> AMViewController
    
    func dismissViewController(_ view: BaseView?)
    
}

protocol SuccessOrderingViewProtocol: BaseView, WithPlaceholder {

    var presenter: SuccessOrderingPresenterProtocol? { get set }

}

protocol SuccessOrderingPresenterProtocol: AnyObject {

    var view: SuccessOrderingViewProtocol? { get set }

    var interactor: SuccessOrderingInteractorInputProtocol? { get set }

    var router: SuccessOrderingRouterProtocol? { get set }

    init(router: SuccessOrderingRouterProtocol, view: SuccessOrderingViewProtocol, interactor: SuccessOrderingInteractorInputProtocol)

    func viewDidLoad()

}

protocol SuccessOrderingInteractorInputProtocol: AnyObject {

    var presenter: SuccessOrderingInteractorOutputProtocol? { get set }
    
    var localStorage: LocaleStorage { get }
    
    var isUserAuth: Bool { get }

}

protocol SuccessOrderingInteractorOutputProtocol: AnyObject {
    
}

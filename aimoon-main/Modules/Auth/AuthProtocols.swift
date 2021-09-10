//
//  AuthProtocols.swift
//  aimoon-main
//

protocol AuthRouterProtocol: BaseRouter {

    static func createModule() -> AMNavigationController
    
    static func createModuleController() -> AMViewController
    
    func openSmsCodeInputViewController(from view: BaseView?, phoneNumber: String, formattedPhoneNumber: String)
    
}

protocol AuthViewProtocol: BaseView, WithUpdatingView {

    var presenter: AuthPresenterProtocol? { get set }
    
    func signInButtonSetState(isEnabled: Bool)

}

protocol AuthPresenterProtocol: AnyObject {

    var view: AuthViewProtocol? { get set }

    var interactor: AuthInteractorInputProtocol? { get set }

    var router: AuthRouterProtocol? { get set }
    
    var phoneNumber: String? { get set }
        
    var formattedPhoneNumber: String? { get set }

    init(router: AuthRouterProtocol, view: AuthViewProtocol, interactor: AuthInteractorInputProtocol)
    
    func viewDidLoad()
    
    func authButtonDidPress(phoneNumber: String, formattedPhoneNumber: String)
    
    func phoneNumberTextDidChange(_ text: String?)

}

protocol AuthInteractorInputProtocol: AnyObject {

    var presenter: AuthInteractorOutputProtocol? { get set }
    
    var localStorage: LocaleStorage { get }
    
    func getSmsCode(phoneNumber: String)
    
}

protocol AuthInteractorOutputProtocol: AnyObject {
    
    func smsCodeDidSendToUser()
    
    func smsCodeSendingDidFail(_ error: API.Error)
    
}

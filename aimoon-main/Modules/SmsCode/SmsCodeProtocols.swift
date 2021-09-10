//
//  SmsCodeProtocols.swift
//  aimoon-main
//

protocol SmsCodeRouterProtocol: BaseRouter {

    static func createModule(phoneNumber: String, formattedPhoneNumber: String) -> AMViewController
    
    func openProfileViewController(from view: BaseView?)
    
}

protocol SmsCodeViewProtocol: BaseView, WithUpdatingView {

    var presenter: SmsCodePresenterProtocol? { get set }
    
    var smsCodeInputView: SmsCodeInputView? { get set }
    
    func clearSmsCodeInputView()
    
    func setSmsCodeInputView(_ view: SmsCodeInputView)
    
    func configureHintView(text: String)

}

protocol SmsCodePresenterProtocol: AnyObject {

    var view: SmsCodeViewProtocol? { get set }

    var interactor: SmsCodeInteractorInputProtocol? { get set }

    var router: SmsCodeRouterProtocol? { get set }
    
    var smsCodeLenght: Int { get }

    init(router: SmsCodeRouterProtocol, view: SmsCodeViewProtocol, interactor: SmsCodeInteractorInputProtocol)

    func viewDidLoad()

}

protocol SmsCodeInteractorInputProtocol: AnyObject {

    var presenter: SmsCodeInteractorOutputProtocol? { get set }
    
    var phoneNumber: String { get }
    
    var formattedPhoneNumber: String { get }
    
    var localStorage: LocaleStorage { get }
    
    init(phoneNumber: String, formattedPhoneNumber: String)
    
    func auth(code: String)
    
    func saveToken(_ token: String)
    
    func getUserInfo()
    
    func saveUserInfo(_ userInfo: UserInfo)

}

protocol SmsCodeInteractorOutputProtocol: AnyObject {
    
    func userInfoDidReceived()
    
    func userInfoRecevingDidFail(_ error: API.Error)
    
    func authDidFail(_ error: API.Error)
    
}

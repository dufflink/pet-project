//
//  SmsCodeRouter.swift
//  aimoon-main
//

final class SmsCodeRouter: SmsCodeRouterProtocol {

    class func createModule(phoneNumber: String, formattedPhoneNumber: String) -> AMViewController {
        let view = R.storyboard.smsCode.smsCodeViewController()!

        let interactor = SmsCodeInteractor(phoneNumber: phoneNumber, formattedPhoneNumber: formattedPhoneNumber)
        let router = SmsCodeRouter()

        let presenter = SmsCodePresenter(router: router, view: view, interactor: interactor)

        view.presenter = presenter
        interactor.presenter = presenter

        return view
    }
    
    func openProfileViewController(from view: BaseView?) {
        let profileModule = ProfileRouter.createModuleController(isUserDidAuth: true)
        view?.push(viewController: profileModule, clearBackStack: true, animated: true)
    }

}

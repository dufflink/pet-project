//
//  AuthRouter.swift
//  aimoon-main
//

import UIKit

final class AuthRouter: AuthRouterProtocol {
    
    class func createModule() -> AMNavigationController {
        let navigationController = R.storyboard.auth.authNavigationController()!

        if let view = navigationController.viewControllers.first as? AuthViewProtocol {
            let interactor = AuthInteractor()
            
            let router = AuthRouter()
            let presenter = AuthPresenter(router: router, view: view, interactor: interactor)
            
            view.presenter = presenter
            interactor.presenter = presenter
        }
        
        return navigationController
    }
    
    class func createModuleController() -> AMViewController {
        let view = R.storyboard.auth.authViewController()!
        let interactor = AuthInteractor()
        
        let router = AuthRouter()
        let presenter = AuthPresenter(router: router, view: view, interactor: interactor)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
    
    func openSmsCodeInputViewController(from view: BaseView?, phoneNumber: String, formattedPhoneNumber: String) {
        let smsCodeModule = SmsCodeRouter.createModule(phoneNumber: phoneNumber, formattedPhoneNumber: formattedPhoneNumber)
        view?.push(viewController: smsCodeModule, clearBackStack: false, animated: true)
    }

}

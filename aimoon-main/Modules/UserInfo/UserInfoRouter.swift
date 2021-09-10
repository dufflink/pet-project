//
//  UserInfoRouter.swift
//  aimoon-main
//

final class UserInfoRouter: UserInfoRouterProtocol {
    
    class func createModule() -> AMViewController {
        let view = R.storyboard.ordering.orderingViewController()!
        
        let interactor = OrderingInteractor(products: [])
        let router = OrderingRouter()

        let presenter = UserInfoPresenter(router: router, view: view, interactor: interactor)

        view.presenter = presenter
        interactor.presenter = presenter

        return view
    }
    
}

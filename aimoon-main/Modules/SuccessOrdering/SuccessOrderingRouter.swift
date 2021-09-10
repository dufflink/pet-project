//
//  SuccessOrderingRouter.swift
//  aimoon-main
//

final class SuccessOrderingRouter: SuccessOrderingRouterProtocol {

    class func createModule() -> AMViewController {
        let view = R.storyboard.successOrdering.successOrderingViewController()!

        let interactor = SuccessOrderingInteractor()
        let router = SuccessOrderingRouter()

        let presenter = SuccessOrderingPresenter(router: router, view: view, interactor: interactor)

        view.presenter = presenter
        interactor.presenter = presenter

        return view
    }
    
    func dismissViewController(_ view: BaseView?) {
        view?.dismiss(animated: true)
    }

}

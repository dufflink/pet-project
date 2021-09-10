//
//  OrderListInteractor.swift
//  aimoon-main
//

final class OrderListInteractor: OrderListInteractorInputProtocol {

    weak var presenter: OrderListInteractorOutputProtocol?
    
    // MARK: - Functions
    
    func getOrderList(page: Int?) {
        API.shared.getOrderList(page).then { [weak self] result in
            guard let metaData = result.metaData else {
                let error = self?.generateUnknownError()
                self?.presenter?.orderListReceivingDidFail(error)
                return
            }
            
            let hasMorePage = metaData.currentPage < metaData.pageCount
            self?.presenter?.orderListDidRecieve(result.items, hasMorePage: hasMorePage)
        }.catch { [weak self] error in
            self?.presenter?.orderListReceivingDidFail(error)
        }
    }
    
    func refreshOrderList() {
        API.shared.getOrderList().then { [weak self] result in
            guard let metaData = result.metaData else {
                let error = self?.generateUnknownError()
                self?.presenter?.orderListRefreshingDidFail(error)
                return
            }
            
            let hasMorePage = metaData.currentPage < metaData.pageCount
            self?.presenter?.orderListRefreshingDidFinish(result.items, hasMorePage: hasMorePage)
        }.catch { [weak self] error in
            self?.presenter?.orderListRefreshingDidFail(error)
        }
    }
    
    // MARK: - Private Functions
    
    private func generateUnknownError() -> API.Error {
        return API.Error(code: .unknown, message: "Meta data не найдена", statusCode: .notFound)
    }

}

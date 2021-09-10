//
//  OrderDetailInteractor.swift
//  aimoon-main
//

final class OrderDetailInteractor: OrderDetailInteractorInputProtocol {

    weak var presenter: OrderDetailInteractorOutputProtocol?
    
    var orderID: Int
    
    // MARK: - Life Cycle
    
    init(orderID: Int) {
        self.orderID = orderID
    }
    
    // MARK: - Functions
    
    func getOrderInfo() {
        API.shared.getOrder(id: orderID).then { [weak self] result in
            self?.presenter?.orderInfoDidReceive(result)
        }.catch { [weak self] error in
            self?.presenter?.orderInfoReceivingDidFail(error)
        }
    }

}

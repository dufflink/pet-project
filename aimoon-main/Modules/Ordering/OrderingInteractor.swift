//
//  OrderingInteractor.swift
//  aimoon-main
//

final class OrderingInteractor: OrderingInteractorInputProtocol {

    weak var presenter: OrderingInteractorOutputProtocol?
    
    var productManager = ProductManager()
    var localStorage = LocaleStorage()
    
    private(set) var products: [OrderProduct]
    
    // MARK: - Life Cycle
    
    init(products: [OrderProduct]) {
        self.products = products
    }
    
    // MARK: - Public Functions
    
    func createOrder(userInfo: UserInfo) {
        presenter?.orderingCreatinDidStart()
        localStorage.userInfo = userInfo
        
        API.shared.createOrder(userInfo: userInfo, products: products).then { [weak self] _ in
            self?.productManager.clearCartProductList()
            self?.presenter?.orderDidCreate()
        }.catch { [weak self] error in
            self?.presenter?.orderCreatingDidFail(error)
        }
    }
    
    func getUserInfo() {
        presenter?.userInfoDidReceive(localStorage.userInfo)
    }

}

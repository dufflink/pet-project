//
//  API.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 03.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import Moya

final class API {
    
    static let shared = API()
    
    private let jsonDecoder = JSONDecoder()
    
    private init() { }
    
    private lazy var provider: MoyaProvider<Method> = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 25
        
        // Что бы вывести логи Moya добавьте параметр plugins в MoyaProvider.init(manager:) с значением [NetworkLoggerPlugin()]
        let session = Session(configuration: configuration)
        let provider = MoyaProvider<API.Method>(session: session)
        
        return provider
    }()
    
    // MARK: - User
    
    func getSmsCode(phoneNumber: String) -> Promise<Empty> {
        let method = API.Method.getSmsCode(phoneNumber: phoneNumber)
        return Promise(method)
    }
    
    func auth(phoneNumber: String, code: Int) -> Promise<AuthData> {
        let method = API.Method.auth(phoneNumber: phoneNumber, code: code)
        return Promise(method)
    }
    
    func getUserInfo() -> Promise<UserInfo> {
        let method = API.Method.getUserInfo
        return Promise(method)
    }
    
    // MARK: - Public Functions
    
    func getHomeScreen() -> Promise<HomeScreen> {
        let method = API.Method.getHomeScreen
        return Promise(method)
    }
    
    func getCategory(id: Int? = nil) -> Promise<Portion<Category>> {
        let method = API.Method.getCategory(id: id)
        return Promise(method)
    }
    
    // MARK: - Products
    
    func getProducts(categoryID: Int, page: Int? = nil) -> Promise<Portion<Product>> {
        let method = API.Method.getProducts(categoryID: categoryID, page: page ?? 1)
        return Promise(method)
    }
    
    func getProduct(id: Int) -> Promise<Product> {
        let method = API.Method.getProduct(id: id)
        return Promise(method)
    }
    
    func getFavoriteProducts() -> Promise<Portion<Product>> {
        let method = API.Method.getFavoriteProducts
        return Promise(method)
    }
    
    func mergeFavoriteProducts(ids: [Int]) -> Promise<Empty> {
        let method = API.Method.mergeFavoriteProducts(ids: ids)
        return Promise(method)
    }
    
    func addFavoriteProduct(id: Int) -> Promise<Empty> {
        let method = API.Method.addFavoriteProduct(id: id)
        return Promise(method)
    }
    
    func deleteFavoriteProduct(id: Int) -> Promise<Empty> {
        let method = API.Method.deleteFavoriteProduct(id: id)
        return Promise(method)
    }
    
    func createOrder(userInfo: UserInfo, products: [OrderProduct]) -> Promise<Empty> {
        let request = OrderRequest(userInfo: userInfo, products: products)
        let method = API.Method.createOrder(request)
        return Promise(method)
    }
    
    func getOrderList(_ page: Int? = nil) -> Promise<Portion<Order>> {
        let method = API.Method.getOrderList(page: page ?? 1)
        return Promise(method)
    }
    
    func getOrder(id: Int) -> Promise<Order> {
        let method = API.Method.getOrder(id: id)
        return Promise(method)
    }
    
    // MARK: - Request Handler
    
    func request<T: Decodable>(_ method: API.Method, with promise: Promise<T>) -> Cancellable {
        return provider.request(method) { response in
            let responseHandler = API.ResponseHandler(response)
            responseHandler.handle(method, with: promise)
        }
    }
    
}

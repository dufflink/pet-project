//
//  API.Method.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 03.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import Moya

extension API {
    
    struct URLConstants {
        
        static let baseURL = URL(string: "http://94.228.118.123:9000")!
        
    }
    
}

extension API {
    
    enum Method: TargetType {
        
        case getHomeScreen
        
        case auth(phoneNumber: String, code: Int)
        case getSmsCode(phoneNumber: String)
        case getUserInfo
        
        case getCategory(id: Int?)
        
        case getProduct(id: Int)
        case getProducts(categoryID: Int, page: Int)
        
        case getFavoriteProducts
        case addFavoriteProduct(id: Int)
        case deleteFavoriteProduct(id: Int)
        case mergeFavoriteProducts(ids: [Int])
        
        case createOrder(_ request: OrderRequest)
        
        case getOrderList(page: Int)
        case getOrder(id: Int)
        
        var baseURL: URL {
            return URLConstants.baseURL
        }
        
        var path: String {
            var target: String
            
            switch self {
                case .auth:
                    target = "auth/code"
                case .getHomeScreen:
                    target = "main-window"
                case .getSmsCode:
                    target = "auth/phone"
                case .getUserInfo:
                    target = "auth/get-profile"
                    
                case .getCategory:
                    target = "category"
                case let .getProduct(id):
                    return "api/products/\(id)"
                case .getProducts:
                    target = "product"
                    
                case .getFavoriteProducts:
                    target = "favorite"
                case .mergeFavoriteProducts:
                    target = "favorite/merge-products"
                case .addFavoriteProduct:
                    target = "favorite/add-product"
                case .deleteFavoriteProduct:
                    target = "favorite/delete-product"
                    
                case .createOrder:
                    target = "order/create"
                case .getOrderList:
                    target = "order"
                case let .getOrder(id):
                    return "api/orders/\(id)"
            }
            
            return "api/\(target)/"
        }
        
        var task: Task {
            var requestObject: Encodable?
            
            var parameters: [String: Any] = [:]
            var bodyParameters: [String: Any]?
            
            switch self {
                case let .auth(phoneNumber, code):
                    bodyParameters = [
                        "phone": phoneNumber,
                        "code": code
                    ]
                    
                case let .getSmsCode(phoneNumber):
                    bodyParameters = [
                        "phone": phoneNumber
                    ]
                    
                case .getCategory(let id):
                    if let id = id {
                        parameters = [
                            "id_category": id
                        ]
                    }
                case .getProducts(let categoryID, let page):
                    parameters = [
                        "id_category": categoryID,
                        "page": page
                    ]
                case let .mergeFavoriteProducts(ids):
                    bodyParameters = ["product_ids": ids]
                case let .deleteFavoriteProduct(id):
                    bodyParameters = ["id_product": id]
                case let .addFavoriteProduct(id):
                    bodyParameters = ["id_product": id]
                case let .createOrder(request):
                    requestObject = request
                case let .getOrderList(page):
                        parameters = [
                            "page": page
                        ]
                default:
                    break
            }
            
            if let requestObject = requestObject {
                return Task.requestJSONEncodable(requestObject)
            }
            
            if let bodyParameters = bodyParameters {
                return .requestCompositeParameters(bodyParameters: bodyParameters, bodyEncoding: JSONEncoding.default, urlParameters: parameters)
            }
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
        
        var sampleData: Data {
            return Data()
        }
        
        var method: Moya.Method {
            switch self {
                case .auth, .getSmsCode:
                    return .post
                case .getHomeScreen:
                    return .get
                case .getUserInfo:
                    return .get
                    
                case .getCategory:
                    return .get
                
                case .getProducts, .getFavoriteProducts, .getProduct:
                    return .get
                case .mergeFavoriteProducts:
                    return .post
                    
                case .addFavoriteProduct, .deleteFavoriteProduct:
                    return .post
                    
                case .createOrder:
                    return .post
                    
                case .getOrderList, .getOrder:
                    return .get
            }
        }
        
        var headers: [String: String]? {
            var headers: [String: String] = [:]
            
            switch self {
//                case .getSmsCode(let data):
//                    headers = ["Authorization": "Basic \(data)"]
                default:
                    if let token = LocaleStorage().accessToken {
                        headers["Authorization"] = "\(token)"
                    }
            }
            
            if let deviceID = UIDevice.current.identifierForVendor?.uuidString {
                headers["Device-Id"] = "\(deviceID)"
            }
            
            return headers
        }
        
    }
    
}

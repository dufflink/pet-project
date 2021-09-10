//
//  UserInfoProtocols.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 11.04.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

protocol UserInfoRouterProtocol: BaseRouter {

    static func createModule() -> AMViewController
    
}

protocol UserInfoInteractorInputProtocol: AnyObject {
    
    var presenter: UserInfoOutputProtocol? { get set }
    
}

protocol UserInfoOutputProtocol: AnyObject { }

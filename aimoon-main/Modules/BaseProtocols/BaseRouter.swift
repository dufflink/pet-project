//
//  BaseRouter.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 21.03.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

protocol BaseRouter: AnyObject {
    
    func popViewController(_ view: BaseView?)
    
}

extension BaseRouter {
    
    func popViewController(_ view: BaseView?) {
        view?.popBack()
    }
    
}

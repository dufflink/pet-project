//
//  AppDelegate.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 04.07.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let mainViewController = MainRouter.createModule()
        Navigation.shared.setRootViewController(mainViewController, setVisibleWindow: true)
        
        return true
    }

}

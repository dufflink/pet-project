//
//  Navigation.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 13.07.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

final class Navigation {
    
    static let shared = Navigation()
    
    private let mainWindow: UIWindow
    
    var window: UIWindow {
        return mainWindow
    }
    
    // MARK: - Life Cycle
    
    private init() {
        mainWindow = UIWindow()
        mainWindow.backgroundColor = .white
        
        if #available(iOS 13, *) {
            mainWindow.overrideUserInterfaceStyle = .light
        }
        
    }
    
    // MARK: - Public Functions
    
    func setRootViewController(_ viewController: UIViewController, setVisibleWindow: Bool = false) {
        mainWindow.rootViewController = viewController
        
        if setVisibleWindow {
            mainWindow.makeKeyAndVisible()
        }
    }
    
}

//
//  WithRefreshControl.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 16.04.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

import UIKit

protocol WithRefreshControl: UIViewController {
    
    var scrollView: UIScrollView { get }
    
    func setRefreshControl()
    
    func removeRefreshControl()
    
    func stopRefreshing()
    
}

// MARK: -

extension WithRefreshControl {
    
    func setRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = R.color.mainColor()
        
        scrollView.refreshControl = refreshControl
    }

    func removeRefreshControl() {
        scrollView.refreshControl = nil
    }

    func stopRefreshing() {
        DispatchQueue.main.async {
            self.scrollView.refreshControl?.endRefreshing()
        }
    }
    
}

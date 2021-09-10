//
//  PlaceholderViewFactory.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 21.09.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

final class PlaceholderViewFactory {
    
    // MARK: - Public Functions
    
    func createPlaceholder(context: PlaceholderViewFactory.Context, delegate: PlaceholderDelegate? = nil) -> PlaceholderView {
        let placeholder = PlaceholderView(context: context, delegate: delegate)
        return placeholder
    }
    
}

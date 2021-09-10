//
//  LoadingRowView.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 17.04.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

import UIKit

final class LoadingRowView: AMView {
    
    override func getParentNib() -> UINib? {
        return UINib(resource: R.nib.loadingRowView)
    }
    
}

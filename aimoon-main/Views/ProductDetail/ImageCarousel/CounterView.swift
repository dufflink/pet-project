//
//  CounterView.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 29.09.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

@IBDesignable final class CounterView: AMView {
    
    @IBOutlet weak var labelView: CounterLabel!
    
    // MARK: - Life Cycle
    
    override func getParentNib() -> UINib? {
        UINib(resource: R.nib.counterView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        update()
    }
    
    // MARK: - Public Functions
    
    func configure(maxCount: Int) {
        labelView.configure(maxCount: maxCount)
    }
    
    func update(currentIndex: Int = 1) {
        labelView.update(currentIndex: currentIndex)
    }
    
    // MARK: - Private Functions
    
    private func configureView() {
        cornerRadius = 6
    }
    
}

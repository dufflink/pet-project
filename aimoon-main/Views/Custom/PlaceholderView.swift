//
//  PlaceholderView.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 05.09.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

protocol PlaceholderDelegate: AnyObject {
    
    func actionButtonDidPress(_ context: PlaceholderViewFactory.Context)
    
}

final class PlaceholderView: AMShowableView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleView: UILabel!
    
    @IBOutlet weak var subtitleView: UILabel!
    @IBOutlet weak var actionButton: AMButton!
    
    private var context: PlaceholderViewFactory.Context!
    
    weak var delegate: PlaceholderDelegate?
        
    // MARK: - Life Cycle
    
    override func getParentNib() -> UINib? {
        return UINib(resource: R.nib.placeholderView)
    }
    
    convenience init(context: PlaceholderViewFactory.Context, delegate: PlaceholderDelegate? = nil) {
        self.init()
        self.context = context
        
        if let subtitle = context.subtitle {
            subtitleView.isHidden = false
            subtitleView.text = subtitle
        }
        
        if let delegate = delegate {
            self.delegate = delegate
            actionButton.isHidden = false
            actionButton.setTitle(context.buttonTitle)
        }
        
        titleView.text = context.title
        imageView.image = context.image
    }
    
    // MARK: - IBAction Functions
    
    @IBAction func actionButtonDidPress(_ sender: Any) {
        delegate?.actionButtonDidPress(context)
    }
    
}

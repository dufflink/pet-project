//
//  RectangleBanner.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 15.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

protocol BannerDelegate: AnyObject {
    
    func bannerDidPress(_ banner: Banner)
    
}

final class RectangleBanner: AMView {
    
    @IBOutlet weak private var headerView: UIView!
    @IBOutlet weak private var titleView: HomeItemTitleView!
    
    @IBOutlet weak private var imageView: UploadableImageView!
    
    @IBOutlet weak private var trailingImageConstraint: NSLayoutConstraint!
    @IBOutlet weak private var leadingImageConstraint: NSLayoutConstraint!
    
    weak var delegate: BannerDelegate?
    private var model: Banner?
    
    override func getParentNib() -> UINib? {
        return UINib(resource: R.nib.rectangleBanner)
    }
    
    // MARK: - Life Cycle
    
    convenience init(homeItem: HomeItem, delegate: BannerDelegate?) {
        self.init()
        self.delegate = delegate
        if let text = homeItem.label {
            titleView.text = text
        } else {
            headerView.isHidden = true
        }
        
        if let banner = homeItem.banners?.first {
            if let url = banner.imageUrl {
                imageView.setImage(from: url)
            }
            
            model = banner
        }
        
        configureView()
    }
    
    convenience init(banner: Banner, delegate: BannerDelegate?, mosaicIndex: Int? = nil) {
        self.init()
        self.delegate = delegate
        headerView.isHidden = true
        
        if let url = banner.imageUrl {
            imageView.setImage(from: url)
        }
        
        if let mosaicIndex = mosaicIndex {
            if mosaicIndex.isMultiple(of: 2) {
                trailingImageConstraint.constant /= 2
            } else {
                leadingImageConstraint.constant /= 2
            }
        }
        
        model = banner
        configureView()
    }
    
    @IBAction func bodyViewDidPress(_ sender: Any) {
        if let banner = model {
            delegate?.bannerDidPress(banner)
        }
    }
    
    // MARK: - Private functions
    
    private func configureView() {
        imageView.cornerRadius = 8
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}

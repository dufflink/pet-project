//
//  ImageViewerPageRow.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 18.10.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

final class ImageViewerPageRow: UICollectionViewCell {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UploadableImageView!
    
    // MARK: - Public Functions
    
    func configure(from image: Image) {
        scrollView.decelerationRate = .fast
        
        scrollView.delegate = self
        imageView.setImage(from: image.url)
    }
    
}

// MARK: - UIScroll View Delegate

extension ImageViewerPageRow: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale < 1 {
            scrollView.setZoomScale(1.0, animated: false)
        }
    }
    
}

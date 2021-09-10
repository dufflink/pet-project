//
//  ImageViewer.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 18.10.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

protocol ImageViewerDelegate: AnyObject {
    
    func currentPageDidChange(_ page: Int)
    
    func imageViewerDidChangeAlpha(_ alpha: CGFloat)
    
    func needDismiss()
    
}

final class ImageViewer: AMShowableView {
    
    @IBOutlet weak var collectionView: ImageViewerCollectionView!
    @IBOutlet weak var counterLabel: CounterLabel!
    
    @IBOutlet weak var priceView: UILabel!
    @IBOutlet weak var titleView: UILabel!
    
    weak var specificDelegate: ImageViewerDelegate?
    
    // MARK: - Life Cycle
    
    override func getParentNib() -> UINib? {
        return UINib(resource: R.nib.imageViewer)
    }
    
    convenience init(product: Product, delegate: ImageViewerDelegate? = nil) {
        self.init()
        priceView.text = "\(product.price) ₽"
        titleView.text = product.name
        
        counterLabel.configure(maxCount: product.images.count, separator: "из")
        collectionView.configure(with: product.images)
        
        collectionView.specificDelegate = self
        translatesAutoresizingMaskIntoConstraints = false
        
        specificDelegate = delegate
        addGestureRecognizer()
    }
    
}

// MARK: - Private Functions

extension ImageViewer: UIGestureRecognizerDelegate {
    
    private func addGestureRecognizer() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handle))
        addGestureRecognizer(pan)
    }

    @objc
    private func handle(_ gesture: UIPanGestureRecognizer) {
        let y = gesture.translation(in: self).y
        
        if gesture.state == .ended {
            if y > center.y / 3 {
                UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
                    self.alpha = 0
                    
                    self.collectionView.transform = CGAffineTransform(translationX: .zero, y: self.frame.height)
                    self.specificDelegate?.imageViewerDidChangeAlpha(0)
                }, completion: { _ in
                    self.specificDelegate?.needDismiss()
                })
            } else {
                UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut) {
                    self.collectionView.transform = .identity
                    self.alpha = 1
                    
                    self.specificDelegate?.imageViewerDidChangeAlpha(1)
                }
            }
        } else if gesture.state != .cancelled {
            guard y > 0 else {
                return
            }
            
            let alpha = 1 - y * 2 / 1000
            
            specificDelegate?.imageViewerDidChangeAlpha(alpha)
            collectionView.transform = CGAffineTransform(translationX: .zero, y: y)
        }
    }
    
}

// MARK: - ImageViewer Collection View Delegate

extension ImageViewer: ImageViewerCollectionViewDelegate {
    
    func pageDidChange(_ currentPage: Int) {
        counterLabel.update(currentIndex: currentPage, separator: "из")
        specificDelegate?.currentPageDidChange(currentPage)
    }
    
}
 

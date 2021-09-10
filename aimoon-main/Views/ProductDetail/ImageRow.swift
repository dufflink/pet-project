//
//  ImageRow.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 29.09.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

final class ImageRow: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UploadableImageView!
    
    // MARK: - Public Functions
    
    func configure(from image: Image) {
        imageView.setImage(from: image.url)
    }
    
}

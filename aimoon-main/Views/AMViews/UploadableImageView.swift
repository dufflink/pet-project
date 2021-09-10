//
//  UploadableImageView.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 15.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import Kingfisher

final class UploadableImageView: UIImageView {
    
    func setImage(from link: String) {
        if let url = URL(string: link) {
            kf.setImage(with: url)
        }
    }
    
}

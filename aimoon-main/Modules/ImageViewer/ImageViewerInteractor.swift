//
//  ImageViewerInteractor.swift
//  aimoon-main
//

import UIKit

final class ImageViewerInteractor: ImageViewerInteractorInputProtocol {

    weak var presenter: ImageViewerInteractorOutputProtocol?
    
    var product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    func getImageData(index: Int) {
        if let image = product.images[safe: index], let url = URL(string: image.url), let data = try? Data(contentsOf: url), let uiImage = UIImage(data: data) {
            presenter?.imageDataDidReceive(image: uiImage)
        } else {
            presenter?.imageDataReceivingDidFail()
        }
    }

}

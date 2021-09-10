//
//  HomeItemViewFactory.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 15.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

final class HomeItemViewFactory {
    
    func createRectangleBanner(from item: HomeItem, delegate: BannerDelegate? = nil) -> AMView {
        var banner: AMView
        
        if (item.banners?.count ?? 1) > 1 {
            banner = CarouselBanner(homeItem: item, delegate: delegate)
        } else {
            banner = RectangleBanner(homeItem: item, delegate: delegate)
        }
    
        banner.heightAnchor.constraint(equalToConstant: HomeItem.ItemType.rectangle.heightOnScreen).isActive = true
        return banner
    }
    
    func createMosaicBanner(from item: HomeItem, delegate: BannerDelegate? = nil) -> AMView? {
        return MosaicBanner(homeItem: item, delegate: delegate)
    }
    
    func createCarouselBanner(from item: HomeItem, products: [Product], delegate: ProductsCollectionViewDelegate? = nil) -> AMView? {
        guard !products.isEmpty else {
            return nil
        }
        
        return CarouselListBanner(products: products, title: item.label, delegate: delegate)
    }
    
    func createRectangleBanners(from banners: [Banner], delegate: BannerDelegate?) -> [RectangleBanner] {
        return banners.enumerated().compactMap { index, banner in
            let rectangleBanner = RectangleBanner(banner: banner, delegate: delegate, mosaicIndex: index)
            let width = Screen.width / 2
            
            rectangleBanner.heightAnchor.constraint(equalToConstant: width).isActive = true
            rectangleBanner.widthAnchor.constraint(equalToConstant: width).isActive = true
            
            return rectangleBanner
        }
    }
    
}

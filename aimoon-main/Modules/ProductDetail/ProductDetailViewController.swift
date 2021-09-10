//
//  ProductDetailViewController.swift
//  aimoon-main
//

import UIKit

final class ProductDetailViewController: AMViewController {

    var presenter: ProductDetailPresenterProtocol?
    
    @IBOutlet weak var priceViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var priceView: UILabel!
    @IBOutlet weak var titleView: UILabel!
    
    @IBOutlet weak var addToCartButton: AMButton!
    
    var amNavigationBar: ProductDetailsNavigationBar?
    var statusBarStyle: UIStatusBarStyle = .lightContent
    
    var updatingView: UpdatingView?
    var placeholder: AMShowableView?
    
    // MARK: - IB Action Function

    @IBAction func addToCartButtonDidPress(_ sender: Any) {
         presenter?.addToCartButtonDidPress()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        scrollView.delegate = self
    }

}

// MARK: - ProductDetail View Protocol

extension ProductDetailViewController: ProductDetailViewProtocol {
    
    func updateTtileView(text: String) {
        titleView.text = text
    }
    
    func updatePriceView(value: String) {
        priceView.text = value
    }
    
    func updateAddToCartButton(text: String, color: UIColor?) {
        addToCartButton.setTitle(text)
        
        addToCartButton.currentBackgroundColor = color
        addToCartButton.highlightedBackgroundColor = color
    }
    
    func setImageCarouselView(_ view: UIView) {
        priceViewTopConstraint.isActive = false
        contentView.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            view.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            view.heightAnchor.constraint(equalToConstant: ViewSize.imageCarousel.value),
            view.bottomAnchor.constraint(equalTo: priceView.topAnchor, constant: -12)
        ])
    }
    
    func setNavigationBar(_ navigationBar: ProductDetailsNavigationBar) {
        // TODO: сделать настраиваемым кастомный бар
        
        setNavBarState(isHidden: true)
        navigationBar.maxAlphaValuePosition = ViewSize.imageCarousel.value - ViewSize.amNavigationBar.value * 1.5
        
        setAmNavigationBar(navigationBar)
        self.amNavigationBar = navigationBar
    }
    
    func setNavBarState(isFavorite: Bool) {
        amNavigationBar?.setFavoriteState(isFavorite)
    }
    
    func setStatusBarStyle(_ style: UIStatusBarStyle) {
        statusBarStyle = style
        
        UIView.animate(withDuration: 0.25) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    func setNavBarState(isHidden: Bool) {
        mainNavBarSetState(isHidden: isHidden)
    }
    
    func share(items: [Any]) {
        let shareViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(shareViewController, animated: true)
    }
    
    func mainViewsSetState(isHidden: Bool) {
        if isHidden {
            addToCartButton.alpha = 0
            scrollView.alpha = 0
        } else {
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) {
                self.addToCartButton.alpha = 1
                self.scrollView.alpha = 1
            }
        }
    }
    
}

// MARK: - UIScrollView Delegate

extension ProductDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        amNavigationBar?.setAlpha(for: position)
    }
    
}

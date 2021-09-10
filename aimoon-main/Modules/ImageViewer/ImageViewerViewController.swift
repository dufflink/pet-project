//
//  ImageViewerViewController.swift
//  aimoon-main
//

import UIKit

final class ImageViewerViewController: AMViewController {

    var presenter: ImageViewerPresenterProtocol?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Life Cycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainNavBarSetState(isHidden: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainNavBarSetState(isHidden: false)
    }

}

// MARK: - ImageViewer View Protocol

extension ImageViewerViewController: ImageViewerViewProtocol {

    func setNavigationBar(_ navigationBar: AMNavigationBar) {
        setAmNavigationBar(navigationBar)
    }
    
    func setImageViewer(_ imageViewer: UIView) {
        view.addSubviewAsContent(imageViewer)
    }
    
    func share(image: UIImage) {
        let shareViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(shareViewController, animated: true)
    }
    
    func setAlpha(_ alpha: CGFloat) {
        view.alpha = alpha
    }
    
}

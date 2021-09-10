//
//  AMViewController.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 13.07.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

protocol KeyboardDelegate: AnyObject {
    
    func keyboardWillShow(height: CGFloat)
    
    func keyboardWillHide()
    
}

class AMViewController: UIViewController {
    
    // MARK: - UI Properties
    
    weak var keyboardDelegate: KeyboardDelegate?
    
    private(set) var isKeyboardShowing = false
    private var lastAvailableHeight: CGFloat?
    
    // MARK: - Properties
    
    @IBInspectable var isAdaptable: Bool = true
    
    var isFullScreen = false {
        didSet {
            setHiddenStateNavigationBar()
        }
    }
    
    var titleColor: UIColor = #colorLiteral(red: 0.1529411765, green: 0.1568627451, blue: 0.1607843137, alpha: 1) {
        didSet {
            setTitleSettings()
        }
    }
    
    var isLargeTitle = false {
        didSet {
            setTitleSize()
        }
    }
    
    var navigationTitle: String? {
        get {
            return navigationItem.title
        } set {
            navigationItem.title = newValue
        }
    }
    
    var navigationBar: UINavigationBar? {
        return navigationController?.navigationBar
    }
    
    var leftBarButtonItem: UIBarButtonItem? {
        get {
            return navigationBar?.topItem?.leftBarButtonItem
        } set {
            navigationBar?.topItem?.leftBarButtonItem = newValue
        }
    }
    
    var rightBarButtonItem: UIBarButtonItem? {
        get {
            return navigationBar?.topItem?.rightBarButtonItem
        } set {
            navigationBar?.topItem?.rightBarButtonItem = newValue
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Warning! Did recieve memory warning [TOViewController]")
    }
    
    // MARK: - Public Functions
    
    func configureView() {
        configureBackBarButtonItem()
        setNeedsStatusBarAppearanceUpdate()
        
        setTitleSettings()
        
        let selector = #selector(keyboardWillChangeFrame)
        NotificationCenter.default.addObserver(self, selector: selector, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func mainNavBarSetState(isHidden: Bool) {
        navigationController?.setNavigationBarHidden(isHidden, animated: false)
    }
    
    func setAmNavigationBar(_ navigationBar: AMNavigationBar) {
        view.addSubview(navigationBar)
        view.bringSubviewToFront(navigationBar)
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: ViewSize.amNavigationBar.value)
        ])
    }
    
    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func layoutView(height: CGFloat, forKeyboardShowing: Bool) {
        isKeyboardShowing = forKeyboardShowing
        
        guard isAdaptable || forKeyboardShowing else {
            return
        }
        
        view.frame = view.frame.with(height: height)
    }
    
    // MARK: - Private Functions
    
    @objc private func keyboardWillChangeFrame(_ notification: Notification) {
        guard let userInfo = notification.userInfo, let currentWindow = UIApplication.shared.keyWindow else {
            return
        }
        
        let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect) ?? .init()
        
        let animatingDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0
        var animatingOptions: UIView.AnimationOptions = []
        
        if let rawValue = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt {
            animatingOptions = .init(rawValue: rawValue)
        }
        
        let isKeyboardShowing = keyboardFrame.minY < currentWindow.bounds.height
        
        let availableHeight = currentWindow.bounds.height - (isKeyboardShowing ? keyboardFrame.height : 0)
        lastAvailableHeight = availableHeight
        
        guard self.isKeyboardShowing != isKeyboardShowing else {
            return
        }
        
        UIView.animate(withDuration: animatingDuration, delay: 0, options: animatingOptions) {
            self.layoutView(height: availableHeight, forKeyboardShowing: isKeyboardShowing)
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func showKeyboard(notification: NSNotification) {
        guard let userInfo = notification.userInfo, !isKeyboardShowing else {
            return
        }
        
        if let keyboardRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size {
            let height = keyboardRect.height - Screen.safeArea.bottom
            
            if height != 0 {
                keyboardDelegate?.keyboardWillShow(height: height)
                isKeyboardShowing = true
            }
        }
    }
    
    @objc private func hideKeyboard() {
        isKeyboardShowing = false
        keyboardDelegate?.keyboardWillHide()
    }
    
    private func setTitleSize() {
        navigationItem.largeTitleDisplayMode = isLargeTitle ? .always : .never
    }
    
    private func setHiddenStateNavigationBar() {
        navigationBar?.isHidden = isFullScreen
    }
    
    private func configureBackBarButtonItem() {
        navigationBar?.backIndicatorImage = #imageLiteral(resourceName: "Back")
        navigationBar?.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "Back")
        navigationBar?.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setTitleSettings() {
        navigationBar?.largeTitleTextAttributes = [.foregroundColor: titleColor]
        navigationBar?.titleTextAttributes = [.foregroundColor: titleColor]
        
        navigationBar?.tintColor = #colorLiteral(red: 1, green: 0.3098039216, blue: 0, alpha: 1)
    }
    
}

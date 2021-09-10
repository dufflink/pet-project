//
//  AMNavigationBar.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 04.10.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

protocol AMNavigationBarDelegate: AnyObject {
    
    func stateDidChange(_ currentState: AMNavigationBar.State)
    
}

class AMNavigationBar: AMView {
    
    @IBOutlet weak var backButton: AMNavBarButton!
    @IBOutlet weak var rightBarButtons: UIStackView!
    
    @IBOutlet weak var separateView: AMSeparateView!
    weak var delegate: AMNavigationBarDelegate?
    
    override func getParentNib() -> UINib? {
        return UINib(resource: R.nib.amNavigationBar)
    }
    
    private var backButtonAction: (() -> Void)?
    
    var viewState: State = .transparent
    var maxAlphaValuePosition: CGFloat = 0
    
    // MARK: - Life Cycle
    
    convenience init(barButtons: [AMNavBarButton], maxAlphaValuePosition: CGFloat = 0, delegate: AMNavigationBarDelegate? = nil, backButtonAction: (() -> Void)?) {
        self.init()
        self.maxAlphaValuePosition = maxAlphaValuePosition
        self.delegate = delegate
        
        configureView()
        
        setupButtons(barButtons: barButtons)
        backButton.action = backButtonAction
    }
    
    convenience init(barButtons: [AMNavBarButton], backButtonImage: UIImage? = nil, backButtonAction: (() -> Void)?) {
        self.init()
        configureView()
        backButton.image = backButtonImage
        
        setupButtons(barButtons: barButtons)
        backButton.action = backButtonAction
    }
     
    // MARK: - Public Functions
    
    func setAlpha(for position: CGFloat) {
        let alpha = (position / maxAlphaValuePosition)
        
        separateView.alpha = alpha
        backgroundColor = UIColor.white.withAlphaComponent(alpha)
        
        var needChangeState = false
        
        if alpha > 0.7 {
            needChangeState = viewState != .regular
        } else {
            needChangeState = viewState != .transparent
        }
        
        if needChangeState {
            viewState = viewState == .regular ? .transparent : .regular
            setBarButtonsState(viewState)
            
            delegate?.stateDidChange(viewState)
        }
    }
    
    func setBarButtonsState(_ state: State) {
        setBarButtonsImageTintColor(state.barButtonColor)
    }
    
    // MARK: - Private Functions
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.white.withAlphaComponent(0.0)
        
        separateView.alpha = 0.0
        setBarButtonsState(.transparent)
    }
    
    private func setupButtons(barButtons: [AMNavBarButton]) {
        rightBarButtons.clear()
        
        barButtons.forEach { button in
            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(equalToConstant: 44),
                button.widthAnchor.constraint(equalToConstant: 44)
            ])
            
            rightBarButtons.addArrangedSubview(button)
        }
    }
    
    private func setBarButtonsImageTintColor(_ tintColor: UIColor) {
        DispatchQueue.main.async { [weak self] in
            self?.rightBarButtons.subviews.forEach { subview in
                if let barButton = subview as? AMNavBarButton {
                    barButton.setImageTintColor(tintColor, withAnimation: true)
                }
            }
            
            self?.backButton.setImageTintColor(tintColor, withAnimation: true)
        }
    }
    
}

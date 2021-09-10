//
//  HomeViewController.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 09.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

final class HomeViewController: AMViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    
    var presenter: HomePresenterProtocol?
    
    var placeholder: AMShowableView?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationTitle = "Home"
    }
    
    override func configureView() {
        super.configureView()
        isLargeTitle = true
    }
    
}

// MARK: - Main View Protocol

extension HomeViewController: HomeViewProtocol {
    
    func setupViews(_ views: [UIView]) {
        stackView.clear()
        
        views.forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    func stackViewSetState(isHidden: Bool) {
        stackView.isHidden = isHidden
    }
    
}

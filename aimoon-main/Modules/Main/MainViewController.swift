//
//  MainViewController.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 08.07.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

final class MainViewController: AMViewController {
    
    var presenter: MainPresenterProtocol?
    
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidLoad()
    }
    
}

// MARK: - Main View Protocol

extension MainViewController: MainViewProtocol {
    
    func showLoadingView() {
        loadingIndicatorView.startAnimating()
    }
    
    func stopLoadingView() {
        loadingIndicatorView.stopAnimating()
    }
    
    func showErrorView(with error: API.Error) {
        let message = error.code == .parsingFailure ? "Не удалось обработать информацию" : "Неизвестная причина"
        showSimpleAlert(with: "Ошибка", message: message, actionTitle: "ОК")
    }
    
}

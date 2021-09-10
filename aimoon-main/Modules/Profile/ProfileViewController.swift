//
//  ProfileViewController.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 30.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

final class ProfileViewController: AMViewController {
    
    var presenter: ProfilePresenterProtocol?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var syncingLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationTitle = "Профиль"
        presenter?.viewDidAppear()
    }
    
    // MARK: - IBAction Functions
    
    @IBAction func logoutButtonDidPress(_ sender: Any) {
        presenter?.logoutButtonDidPress()
    }
    
    // MARK: - Private Functions
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(UINib(resource: R.nib.profileMenuRow), forCellReuseIdentifier: R.reuseIdentifier.profileMenuRow.identifier)
    }
    
}

// MARK: - Main View Protocol

extension ProfileViewController: ProfileViewProtocol {
    
    func updateTableView() {
        tableView.reloadData()
    }
    
    func showAlert(_ alert: UIAlertController) {
        present(alert, animated: true)
    }
    
    func syncingLabelSetState(isHidden: Bool) {
        let options: UIView.AnimationOptions = isHidden ? .curveEaseOut : .curveEaseIn
        let delay: TimeInterval = isHidden ? 1 : 0
        
        UIView.animate(withDuration: 0.25, delay: delay, options: options) {
            self.syncingLabel.alpha = isHidden ? 0 : 1
        }
    }
    
}

// MARK: - UITableView Delegate

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didSelectRow(at: indexPath)
    }
    
}

// MARK: - UITableView Data Source

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.menuRowsCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.profileMenuRow, for: indexPath)
        if let menuRow = presenter?.menuRows?[safe: indexPath.row] {
            row?.configure(from: menuRow)
        }
        
        return row ?? UITableViewCell()
    }
    
}

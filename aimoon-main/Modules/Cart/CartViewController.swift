//
//  CartViewController.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 30.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

final class CartViewController: AMViewController {
    
    var presenter: CartPresenterProtocol?
    var placeholder: AMShowableView?
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var checkoutButton: AMButton!
    
    @IBOutlet private weak var bottomView: UIView!
    @IBOutlet private weak var totalAmountLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationTitle = "Корзина"
    }
    
    // MARK: - Builder Functions
    
    @IBAction private func checkoutButtonDidPress(_ sender: Any) {
        presenter?.checkoutButtonDidPress()
    }
    
    // MARK: - Private Functions
    
    private func configureTableView() {
        tableView.register(UINib(resource: R.nib.cartRow), forCellReuseIdentifier: R.nib.cartRow.identifier)
    }
    
}

// MARK: - Main View Protocol

extension CartViewController: CartViewProtocol {
    
    func updateTableView() {
        tableView.reloadData()
    }
    
    func setTotalAmountView(value: String) {
        totalAmountLabel.text = value
    }
    
    func setBottomViewState(isHidden: Bool) {
        bottomView.isHidden = isHidden
    }
    
    func setTableViewState(isHidden: Bool) {
        tableView.isHidden = isHidden
    }
    
}

// MARK: - Table View Data Source

extension CartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.products.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.cartRow, for: indexPath)
        
        if let model = presenter?.products[indexPath.row] {
            let delegate = presenter as? CartRowDelegate
            row?.configure(from: model, indexPath: indexPath, delegate: delegate)
        }
        
        return row ?? UITableViewCell()
    }
    
}

// MARK: - Table View Delegate

extension CartViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didSelectRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124
    }

}

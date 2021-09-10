//
//  CategoriesViewController.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 30.08.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import UIKit

final class CategoriesViewController: AMViewController {
    
    var presenter: CategoriesPresenterProtocol?
    
    var placeholder: AMShowableView?
    var updatingView: UpdatingView?
    
    @IBOutlet weak var allProductsButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var allProductsButton: AMButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    @IBAction func allProductsButtonDidPress(_ sender: Any) {
        presenter?.allProductsButtonDidPress()
    }
    
}

// MARK: - Private Functions

extension CategoriesViewController {
    
    private func configureTableView() {
        tableView.register(UINib(resource: R.nib.categoryRow), forCellReuseIdentifier: R.reuseIdentifier.categoryRow.identifier)
    }
    
}

// MARK: - UITableView Data Source

extension CategoriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.categoriesCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = tableView.dequeueReusableCell(withIdentifier: R.nib.categoryRow, for: indexPath)
        
        if let model = presenter?.categories[indexPath.row] {
            row?.configure(from: model)
        }
        
        return row ?? UITableViewCell()
    }
    
}

// MARK: - UITableView Delegate

extension CategoriesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didSelectCategory(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
}

// MARK: - Main View Protocol

extension CategoriesViewController: CategoriesViewProtocol {
    
    func updateTableView() {
        tableView.reloadData()
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setAllProductsButtonTitle(_ title: String) {
        allProductsButton.setTitle(title)
    }
    
    func allProductsButtonSetState(isHidden: Bool) {
        allProductsButton.isHidden = isHidden
        allProductsButtonHeight.constant = isHidden ? 0 : 44
    }
    
    func tablViewSetState(isHidden: Bool) {
        tableView.isHidden = isHidden
    }
    
}

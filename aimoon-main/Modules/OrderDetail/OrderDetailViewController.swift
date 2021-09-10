//
//  OrderDetailViewController.swift
//  aimoon-main
//

import UIKit

final class OrderDetailViewController: AMViewController {

    var presenter: OrderDetailPresenterProtocol?
    
    @IBOutlet private weak var tableViewTitleView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    
    var userInfoView: OrderUserInfoStackView?
    
    var placeholder: AMShowableView?
    var updatingView: UpdatingView?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        presenter?.viewDidLoad()
    }
    
    // MARK: - Private Functions
    
    private func configureTableView() {
        tableView.register(UINib(resource: R.nib.cartRow), forCellReuseIdentifier: R.nib.cartRow.identifier)
    }

}

// MARK: - OrderDetail View Protocol

extension OrderDetailViewController: OrderDetailViewProtocol {

    func updateTableView() {
        tableView.reloadData()
    }
    
    func setHeaderView(_ headerView: UIView) {
        guard let userInfoView = userInfoView else {
            return
        }
        
        view.addSubview(headerView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: userInfoView.topAnchor)
        ])
    }
    
    func setUserInfoView(_ userInfoView: OrderUserInfoStackView) {
        self.userInfoView = userInfoView
        view.addSubview(userInfoView)
        
        NSLayoutConstraint.activate([
            userInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userInfoView.bottomAnchor.constraint(equalTo: tableViewTitleView.topAnchor)
        ])
    }
    
    func viewsSetState(isHidden: Bool) {
        tableView.isHidden = isHidden
        tableViewTitleView.isHidden = isHidden
    }
    
}

// MARK: - UITableView Data Source

extension OrderDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.order?.products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = tableView.dequeueReusableCell(withIdentifier: R.nib.cartRow, for: indexPath)
        
        if let model = presenter?.order?.products?[indexPath.row] {
            row?.configure(from: model, needShowRemoveButton: false)
        }
        
        return row ?? UITableViewCell()
    }
    
}

// MARK: - UITableView Delegate

extension OrderDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didSelectRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124
    }
    
}

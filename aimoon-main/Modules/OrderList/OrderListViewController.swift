//
//  OrderListViewController.swift
//  aimoon-main
//

import UIKit

final class OrderListViewController: AMViewController {

    var presenter: OrderListPresenterProtocol?

    @IBOutlet private weak var tableView: UITableView!
    
    private let loadingRowHeight: CGFloat = 60
    
    var updatingView: UpdatingView?
    var placeholder: AMShowableView?
    
    var scrollView: UIScrollView {
        return tableView
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SchedulingHelper.shared.removeTask(.openUserOrders)
    }
    
    // MARK: - Private Functions
    
    private func configureTableView() {
        tableView.tableFooterView = LoadingRowView()
        tableView.register(UINib(resource: R.nib.orderRow), forCellReuseIdentifier: R.reuseIdentifier.orderRow.identifier)
    }

}

// MARK: - OrderList View Protocol

extension OrderListViewController: OrderListViewProtocol {
    
    func updateTableView() {
        tableView.reloadData()
    }
    
    func tableViewSetState(isHidden: Bool) {
        tableView.isHidden = isHidden
    }
    
    func setTableViewFooter(isHidden: Bool) {
        tableView.tableFooterView?.frame.size.height = isHidden ? 0 : loadingRowHeight
        tableView.tableFooterView?.isHidden = isHidden
    }
    
}

// MARK: - UITableView Data Source

extension OrderListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.orders.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = tableView.dequeueReusableCell(withIdentifier: R.nib.orderRow, for: indexPath)
        
        if let model = presenter?.orders[indexPath.row] {
            row?.configure(from: model)
        }
        
        return row ?? UITableViewCell()
    }
    
}

// MARK: - UITableView Delegate

extension OrderListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didSelectRow(at: indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard presenter?.hasMorePage == true && presenter?.isLoading == false else {
            return
        }
        
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        let offset = maximumOffset - contentOffset
        let screenOffset = UIScreen.main.bounds.height / 2
        
        if offset <= screenOffset && offset != 0.0 {
            presenter?.scrollViewDidScrollToBottom()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let refreshControl = tableView.refreshControl else {
            return
        }
        
        if refreshControl.isRefreshing && presenter?.isLoading == false {
            presenter?.refreshControllDidBeginRefreshing()
        }
    }
    
}

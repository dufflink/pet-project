//
//  ProductListViewController.swift
//  aimoon-main
//

import UIKit

final class ProductListViewController: AMViewController {
    
    var presenter: ProductListPresenterProtocol?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewToTopConstraint: NSLayoutConstraint!
    
    private let loadingRowHeight: CGFloat = 50
    
    private var widthRow: CGFloat = 0
    private var heightRow: CGFloat = 0
    
    var updatingView: UpdatingView?
    var placeholder: AMShowableView?
    
    var headerView: ProductListHeaderView?
    
    var scrollView: UIScrollView {
        return collectionView
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        presenter?.viewDidLoad()
    }
    
    private func configureCollectionView() {
        let newCollectionViewLayout = UICollectionViewFlowLayout()
        newCollectionViewLayout.scrollDirection = .vertical
        
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        newCollectionViewLayout.minimumLineSpacing = 8
        newCollectionViewLayout.minimumInteritemSpacing = 2
        
        widthRow = (Screen.width - 24) / 2
        heightRow = 220
        
        collectionView.collectionViewLayout = newCollectionViewLayout
        collectionView.register(UINib(resource: R.nib.productRow), forCellWithReuseIdentifier: R.nib.productRow.identifier)
        
        collectionView.register(UINib(resource: R.nib.loadingRow), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LoadingRow.identifier)
    }

}

// MARK: - Products View Protocol

extension ProductListViewController: ProductListViewProtocol {
    
    func updateRow(at indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
    
    func removeRow(at indexPath: IndexPath) {
        collectionView.reloadData()
    }
    
    func insertRow(at indexPath: IndexPath) {
        collectionView.insertItems(at: [indexPath])
    }
    
    func updateCollectionView() {
        collectionView.reloadData()
    }
    
    func collectionViewSetState(isHidden: Bool) {
        collectionView.isHidden = isHidden
    }
    
    func configureHeaderView(_ newHeaderView: ProductListHeaderView) {
        // Очень странное поведение констрейнтов.
        collectionViewToTopConstraint.constant = 56
        
        view.addSubview(newHeaderView)
        
        NSLayoutConstraint.activate([
            newHeaderView.topAnchor.constraint(equalTo: view.topAnchor),
            newHeaderView.bottomAnchor.constraint(equalTo: collectionView.topAnchor),
            newHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        headerView = newHeaderView
    }
    
}

// MARK: - UICollectionViewDataSource Functions

extension ProductListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.productsCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.productRow, for: indexPath)
        
        if let model = presenter?.products[indexPath.row], let needShowFavoriteItem = presenter?.needShowFavoriteItem {
            let delegate = presenter as? ProductRowDelegate
            row?.configure(from: model, indexPath: indexPath, delegate: delegate, needShowFavoriteItem: needShowFavoriteItem)
        }
        
        return row ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var footerView = UICollectionReusableView()
        if presenter?.hasMorePage == true {
            footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LoadingRow.identifier, for: indexPath)
        }
        
        return footerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return presenter?.hasMorePage == true ? .init(width: view.frame.width, height: loadingRowHeight) : .zero
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout Functions

extension ProductListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectRow(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: widthRow, height: heightRow)
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
        guard let refreshControl = collectionView.refreshControl else {
            return
        }
        
        if refreshControl.isRefreshing && presenter?.isLoading == false {
            presenter?.refreshControllDidBeginRefreshing()
        }
    }
    
}

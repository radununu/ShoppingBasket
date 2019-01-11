//
//  ProductListView.swift
//  ShoppingBasket
//

import UIKit

class ProductList: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var checkoutButton: UITabBarItem!
    private var productList = [Product]()
    var presenter: ProductListPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        title = Constants.title
    }

}

private extension ProductList {
    struct Constants {
        static let title = "Products"
        static let cellIdentifier = "CellIdentifier"
    }
}

extension ProductList: UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as? ProductListCell
            else {
            fatalError()
        }
        cell.configureCellWith(model: productList[indexPath.row], delegate: self)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == checkoutButton {
            presenter?.didSelectCheckout(with: productList)
        }
    }
}

extension ProductList: ProductCellOutput {
    func didChangeValueIn(cell: ProductListCell, value: Int) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        productList[indexPath.row].quantity = value
        presenter?.updateTotalQuantityFor(list: productList)
    }
}

extension ProductList: ProductListInput {
    func showProductList(list products: [Product]) {
        productList = products
        tableView.reloadData()
    }

    func updateBadge(value: String) {
        checkoutButton.badgeValue = value
        checkoutButton.isEnabled = Int(value) ?? 0 > 0
    }
}

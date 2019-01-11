//
//  ProductListPresenter.swift
//  ShoppingBasket
//

import UIKit

protocol ProductListInput: class {
    func showProductList(list products: [Product])
    func updateBadge(value: String)
}

protocol ProductListOutput {
    func loadData()
    func didSelectCheckout(with products: [Product])
}

class ProductListPresenter {
    
    weak var viewInput: ProductListInput?
    private let router: ProductListRouter
    private let interactor: ProductListInteractor
    
    init(router: ProductListRouter, interactor: ProductListInteractor) {
        self.router = router
        self.interactor = interactor
    }
    
    func updateTotalQuantityFor(list: [Product]) {
        let totalQuantity = String(list.map{ return $0.quantity}.reduce(0, +))
        viewInput?.updateBadge(value: totalQuantity)
    }
    
    func didLoadListOf(products: [Product]) {
        viewInput?.showProductList(list: products)
        updateTotalQuantityFor(list: products)
    }
}

extension ProductListPresenter: ProductListOutput {
    
    func loadData() {
        viewInput?.showProductList(list: interactor.loadMainProductListLocally())
    }

    func didSelectCheckout(with products: [Product]) {
        router.displayCheckout(with: products)
    }
}

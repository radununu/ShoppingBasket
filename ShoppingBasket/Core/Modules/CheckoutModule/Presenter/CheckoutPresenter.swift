//
//  CheckoutPresenter.swift
//  ShoppingBasket
//

import Foundation

protocol CheckoutOutput {
    func didChangeCurency(currencyCode: String)
    func getCurrencyList() -> [String]
    func selectedCurrencyIndex() -> Int
}

protocol CheckoutInput: class {
    func displayBasketInformation(with numberOfItems: String, totalCost: String)
    func displayError(with message: String)
}

class CheckoutPresenter {
    private let router: CheckoutRouter
    private let interactor: CheckoutInteractorProtocol
    weak var viewInput: CheckoutInput?
    private let products: [Product]
    
    init(router: CheckoutRouter, products: [Product], interactor: CheckoutInteractorProtocol) {
        self.router = router
        self.products = products
        self.interactor = interactor
    }
    
    func didLoadView() {
        interactor.requestConvertor { [weak self] error in
            self?.viewInput?.displayError(with: error)
        }
        processBascketInformation()
    }
}

private extension CheckoutPresenter {
    
    func processBascketInformation(currencyCode: String = Currency.defaultCurrency, needsConverting: Bool = false) {
        let itemNumber = products.map { $0.quantity }.reduce(0, +)
        let totalAmount = products.map { Double($0.quantity) * $0.price }.reduce(0, +)
        var formattedPrice = NumberFormatter.formattedPrice(with: totalAmount, currencyCode: currencyCode)

        if needsConverting {
            formattedPrice = interactor.exchangeMoney(with: totalAmount, for: currencyCode)
        }
        viewInput?.displayBasketInformation(with: String(itemNumber), totalCost: formattedPrice)
    }
}

extension CheckoutPresenter: CheckoutOutput {
    func selectedCurrencyIndex() -> Int {
        return interactor.getIndexOfCurrentCurrency()
    }

    func getCurrencyList() -> [String] {
        return interactor.extractCurrencyList()
    }

    func didChangeCurency(currencyCode: String) {
        processBascketInformation(currencyCode: currencyCode, needsConverting: true)
    }
}

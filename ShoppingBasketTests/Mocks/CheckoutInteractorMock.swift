//
//  CheckoutInteractorMock.swift
//  ShoppingBasketTests
//
//  Created by Radu Nunu on 10/01/2019.
//

import XCTest
@testable import ShoppingBasket

class CheckoutInteractorMock: CheckoutInteractorProtocol  {
    private let expectation: XCTestExpectation?
    private let result: CurrencyConvertor
    private var currentCurrency = Currency.defaultCurrency

    init(expectation: XCTestExpectation? = nil, result: CurrencyConvertor) {
        self.expectation = expectation
        self.result = result
    }

    func requestConvertor(alertCompletion: @escaping (String) -> ()) {

    }

    func extractCurrencyList() -> [String] {
        return result.quotes.map { $0.name }
    }

    func exchangeMoney(with totalValue: Double, for currencyCode: String) -> String {
        guard let currency = result.quotes.first(where: { $0.name == currencyCode }) else {
                return ""
        }
        self.currentCurrency = currencyCode
        return NumberFormatter.formattedPrice(with: currency.value * totalValue, currencyCode: currency.name)
    }

    func getIndexOfCurrentCurrency() -> Int {
        guard let currency = result.quotes.first(where: { $0.name == currentCurrency }),
            let index = result.quotes.firstIndex(of: currency) else {
                return 0
        }

        return index
    }

}

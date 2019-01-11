//
//  CheckoutInteractor.swift
//  ShoppingBasket
//

import Foundation

protocol CheckoutInteractorProtocol {
    func requestConvertor(alertCompletion: @escaping (String) -> ())
    func extractCurrencyList() -> [String]
    func exchangeMoney(with totalValue: Double, for currencyCode: String) -> String
    func getIndexOfCurrentCurrency() -> Int
}

class CheckoutInteractor: CheckoutInteractorProtocol {
    private let networkservice: NetworkServiceProtocol
    private var currencyConvertor: CurrencyConvertor?
    private var currentCurrency = Currency.defaultCurrency
    
    init(networkService: NetworkServiceProtocol) {
        self.networkservice = networkService
    }

    func requestConvertor(alertCompletion: @escaping (String) -> ()) {
        networkservice.request(with: CurrencyEndpoint.getCurrencies, responseType: CurrencyConvertor.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let value):
                strongSelf.currencyConvertor = value
            case .error(let error):
                guard let errorDescription = error?.localizedDescription else {
                    return alertCompletion("Something went wrong!")
                }
                alertCompletion(errorDescription)
            }
        }
    }

    func extractCurrencyList() -> [String] {
        guard let convertor = currencyConvertor else {
            return []
        }
        return convertor.quotes.map { $0.name }
    }

    func exchangeMoney(with totalValue: Double, for currencyCode: String) -> String {
        guard let convertor = currencyConvertor,
            let currency = convertor.quotes.first(where: { $0.name == currencyCode }) else {
                return ""
        }
        currentCurrency = currencyCode
        return NumberFormatter.formattedPrice(with: currency.value * totalValue, currencyCode: currency.name)
    }

    func getIndexOfCurrentCurrency() -> Int {
        guard let convertor = currencyConvertor,
            let currency = convertor.quotes.first(where: { $0.name == currentCurrency }),
            let index = convertor.quotes.firstIndex(of: currency) else {
                return 0
        }

        return index
    }
}

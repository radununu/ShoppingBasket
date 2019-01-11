//
//  CheckoutInteractorTests.swift
//  ShoppingBasketTests
//
//  Created by Radu Nunu on 10/01/2019.
//

import XCTest
@testable import ShoppingBasket

class CheckoutInteractorTests: XCTestCase {

    func testInitOK() {
        // given
        let expectation = XCTestExpectation(description: "mock")
        let result: Result<String> = .success(nil)
        let networkService = NetworkServiceMock(expectation: expectation, resultMock: result)

        // when
        let interactor = CheckoutInteractor(networkService: networkService)

        // then
        XCTAssertNotNil(interactor)
    }

    func testGetCurrencyOK() {
        // given
        let expectation = XCTestExpectation(description: "get-currency-ok")
        let euro = Currency(name: "EUR", value: 1.2)
        let pount = Currency(name: "GBP", value: 1.37)
        let chf = Currency(name: "CHF", value: 1.01)
        let currencyConvertor = CurrencyConvertor(source: "", quotes: [euro,pount,chf])
        let result: Result<CurrencyConvertor> = .success(currencyConvertor)
        let networkService = NetworkServiceMock(expectation: expectation, resultMock: result)
        let interactor = CheckoutInteractor(networkService: networkService)

        // when
        interactor.requestConvertor { _ in
            XCTAssertEqual(interactor.exchangeMoney(with: 20, for: "EURO"), "€24")
            XCTAssertEqual(interactor.extractCurrencyList(), ["EUR", "GBP", "CHF"])
            XCTAssertEqual(interactor.getIndexOfCurrentCurrency(), 0)
            XCTAssertEqual(interactor.exchangeMoney(with: 20, for: "CHF"), "₣20.2")
            XCTAssertEqual(interactor.getIndexOfCurrentCurrency(), 2)
        }
        // then
        wait(for: [expectation], timeout: 0.1)
    }

    func testGetCurrencyFails() {
        // given
        let expectation = XCTestExpectation(description: "get-currency-Fails")

        let error = NSError(domain: "", code: 301, userInfo: [NSLocalizedDescriptionKey: "Something Went Wrong"])
        let result: Result<CurrencyConvertor> = .error(error)
        let networkService = NetworkServiceMock(expectation: expectation, resultMock: result)
        let interactor = CheckoutInteractor(networkService: networkService)

        // when
        interactor.requestConvertor { localizedError in
            XCTAssertEqual(localizedError, "Something Went Wrong")
            XCTAssertEqual(interactor.extractCurrencyList(), [])
            XCTAssertEqual(interactor.exchangeMoney(with: 1, for: "EUR"), "")
            XCTAssertEqual(interactor.getIndexOfCurrentCurrency(), 0)
        }
        // then
        wait(for: [expectation], timeout: 0.1)
    }
}

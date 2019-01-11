//
//  NumberFormatterTests.swift
//  ShoppingBasketTests
//
//  Created by Radu Nunu on 10/01/2019.
//

import XCTest
@testable import ShoppingBasket

class NumberFormatterTests: XCTestCase {

    func testformattedPrice() {
        XCTAssertEqual(NumberFormatter.formattedPrice(with: 20.50, currencyCode: "USD"), "$20.50")
        XCTAssertEqual(NumberFormatter.formattedPrice(with: 12.15, currencyCode: "EUR"), "€12.15")
    }
}

//
//  ProductListInteractorTests.swift
//  ShoppingBasketTests
//
//  Created by Radu Nunu on 11/01/2019.
//

import XCTest
@testable import ShoppingBasket

class ProductListInteractorTests: XCTestCase {

    func testGetMainList() {
        let interactor = ProductListInteractor()
        XCTAssertEqual(interactor.loadMainProductListLocally().count, 4)
        XCTAssertEqual(interactor.loadMainProductListLocally()[1].name, "Eggs")
    }

}

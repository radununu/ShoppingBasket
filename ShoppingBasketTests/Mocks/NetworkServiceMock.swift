//
//  NetworkServiceMock.swift
//  ShoppingBasketTests
//
//  Created by Radu Nunu on 10/01/2019.
//

import XCTest
@testable import ShoppingBasket

struct NetworkServiceMock<Type: Codable>: NetworkServiceProtocol {
    private let expectation: XCTestExpectation
    private let resultMock: Result<Type>

    init(expectation: XCTestExpectation, resultMock: Result<Type>) {
        self.expectation = expectation
        self.resultMock = resultMock
    }

    func request<T: Decodable>(with: Endpoint, responseType: T.Type, handler: @escaping (Result<T>) -> Void) {
        self.expectation.fulfill()
        handler(self.resultMock as! Result<T>)
    }
}

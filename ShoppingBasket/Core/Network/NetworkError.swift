//
//  NetworkError.swift
//  ShoppingBasket
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case unableToSerialize
    case emptyResponse
}

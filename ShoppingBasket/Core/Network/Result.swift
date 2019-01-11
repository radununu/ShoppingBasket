//
//  Result.swift
//  ShoppingBasket
//

import Foundation

enum Result<T> {
    case success(T?)
    case error(Error?)
}

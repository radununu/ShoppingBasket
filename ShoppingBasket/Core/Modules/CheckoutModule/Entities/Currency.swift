//
//  Currency.swift
//  ShoppingBasket
//


import Foundation

struct Currency: Codable, Equatable {
    static let defaultCurrency = "USD"

    let name: String
    let value: Double
}

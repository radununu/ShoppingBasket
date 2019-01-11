//
//  NumberFormatter+Extension.swift
//  ShoppingBasket
//
//  Created by Radu Nunu on 10/01/2019.
//

import Foundation


public extension NumberFormatter {

    static func formattedPrice(with value: Double, currencyCode: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        guard let formattedPrice = formatter.string(from: NSNumber(value: value)) else {
            return ""
        }

        return formattedPrice
    }
}

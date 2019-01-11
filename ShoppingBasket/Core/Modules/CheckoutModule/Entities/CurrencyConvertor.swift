//
//  CurrencyList.swift
//  ShoppingBasket
//
//  Created by Radu Nunu on 09/01/2019.
//

import Foundation

struct CurrencyConvertor: Codable {
    let source: String
    let quotes: [Currency]

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let decodedQuotes = try values.decode([String: Double].self, forKey: .quotes)
        source = try values.decode(String.self, forKey: .source)
        quotes = decodedQuotes.map {
            Currency(name: $0.key.replacingOccurrences(of: Currency.defaultCurrency, with: ""),
                     value: $0.value)
        }
    }

    init(source: String, quotes: [Currency]) {
        self.source = source
        self.quotes = quotes
    }
}

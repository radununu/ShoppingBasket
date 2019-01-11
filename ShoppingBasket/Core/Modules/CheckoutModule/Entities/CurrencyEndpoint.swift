//
//  CurrencyEndpoint.swift
//  ShoppingBasket
//
//  Created by Radu Nunu on 08/01/2019.
//

import Foundation

enum CurrencyEndpoint: Endpoint {
    case getCurrencies

    var method: HTTPMethod {
        switch self {
        case .getCurrencies:
            return .get
        }
    }

    var host: String {
        return "http://apilayer.net/api"
    }

    var path: String {
        switch self {
        case .getCurrencies:
            return "/live"
        }
    }

    var header: [String : String]? {
        return nil
    }

    var queryParameters: [String: String]? {
        return [ Constants.accessKey: Constants.apiAccessKey,
                 Constants.formatKey: "1" ]
    }
}

private struct Constants {
    static let accessKey = "access_key"
    static let apiAccessKey = "024696242a67aa855e446fccd09c54db"
    static let formatKey = "format"
}

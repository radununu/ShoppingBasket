//
//  Endpoint.swift
//  ShoppingBasket
//

import Foundation

protocol Endpoint {
    var method: HTTPMethod { get }
    var host: String { get }
    var path: String { get }
    var header: [String: String]? { get }
    var queryParameters: [String: String]? { get }
}

extension Endpoint {
    var url: URL? {
        guard let url = URL(string: host + path) else {
            return nil
        }
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true),
            let queryParameters = queryParameters else {
            return url
        }

        urlComponents.queryItems = queryParameters.map { URLQueryItem(name: $0, value: $1) }
        return urlComponents.url
    }
}

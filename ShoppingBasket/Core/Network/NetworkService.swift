//
//  NetworkService.swift
//  ShoppingBasket
//

import Foundation


protocol NetworkServiceProtocol {
    func request<T: Decodable>(with: Endpoint, responseType: T.Type, handler: @escaping (Result<T>) -> Void)
}

struct NetworkService: NetworkServiceProtocol {
    func request<T: Decodable>(with endpoint: Endpoint,
                               responseType: T.Type,
                               handler: @escaping (Result<T>) -> Void) {
        guard let url = endpoint.url else {
            handler(.error(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard error == nil else {
                handler(.error(error))
                return
            }

            guard let data = data else {
                handler(.error(NetworkError.emptyResponse))
                return
            }

            guard let result = try? JSONDecoder().decode(responseType, from: data) else {
                handler(.error(NetworkError.unableToSerialize))
                return
            }

            handler(.success(result))
            }.resume()
    }
}

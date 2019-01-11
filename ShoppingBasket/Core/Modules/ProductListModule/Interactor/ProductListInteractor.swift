//
//  ProductListInteractor.swift
//  ShoppingBasket
//

import UIKit

class ProductListInteractor {

    func loadMainProductListLocally() -> [Product] {
        guard let url = Bundle.main.url(forResource: Constants.resourceFileName, withExtension: Constants.resourceFileType), let data = try? Data(contentsOf: url),
            let items = try? PropertyListDecoder().decode([Product].self, from: data) else {
                return []
        }
        return items
    }

}

private extension ProductListInteractor {
    struct Constants {
        static let resourceFileName = "MainProductList"
        static let resourceFileType = "plist"
    }
}

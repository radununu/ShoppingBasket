//
//  CheckoutRouterRouter.swift
//  ShoppingBasket
//

import UIKit

class CheckoutRouter {

    func getShoppingBasket(with products: [Product]) -> UINavigationController {
        let storyBoard = UIStoryboard(name: "CheckoutBoard", bundle: nil)
        guard let checkoutView = storyBoard.instantiateInitialViewController() as? CheckoutView else {
            return UINavigationController(rootViewController: UIViewController())
        }
        let presenter = CheckoutPresenter(router: self,
                                          products: products,
                                          interactor: CheckoutInteractor(networkService: NetworkService())
        )
        presenter.viewInput = checkoutView
        checkoutView.presenter = presenter
        return UINavigationController(rootViewController: checkoutView)
    }

}

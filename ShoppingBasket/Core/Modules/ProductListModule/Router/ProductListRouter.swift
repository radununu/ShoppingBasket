//
//  ProductListRouter.swift
//  ShoppingBasket
//

import UIKit

class ProductListRouter {
    private var navigationController: UINavigationController?

    func getProductListModuleView() -> UINavigationController {
        let storyBoard = UIStoryboard(name:"ProductListBoard", bundle:nil)
        guard let view = storyBoard.instantiateInitialViewController() as? ProductList else {
            return UINavigationController(rootViewController: UIViewController())
        }

        let presenter = ProductListPresenter(router: self, interactor: ProductListInteractor())
        presenter.viewInput = view
        view.presenter = presenter
        navigationController = UINavigationController(rootViewController: view)
        return navigationController!
    }
    
    func displayCheckout(with products: [Product]) {
        guard let navigationController = navigationController else {
            return
        }
        let checkoutRouter = CheckoutRouter()
        navigationController.present(checkoutRouter.getShoppingBasket(with: products), animated: true)
    }
}

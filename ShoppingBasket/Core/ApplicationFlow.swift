//
//  ApplicationFlow.swift
//  ShoppingBasket
//

import UIKit

struct ApplicationFlow {
    
    static func applicationFlowIn(window: UIWindow) {
        window.rootViewController = ProductListRouter().getProductListModuleView()
        window.makeKeyAndVisible()
    }

}

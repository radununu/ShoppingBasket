//
//  AppDelegate.swift
//  ShoppingBasket
//


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        if let unwrappedWindow = window {
            ApplicationFlow.applicationFlowIn(window: unwrappedWindow)
        }
        return true
    }

}

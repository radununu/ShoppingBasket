//
//  CheckoutView.swift
//  ShoppingBasket
//

import UIKit

class CheckoutView: UIViewController {
    @IBOutlet weak var totalAmountOfMoney: UILabel!
    var presenter: CheckoutPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.screenTitle
        setupNavigationItems()
        presenter?.didLoadView()
    }

    @IBAction func didSelectChangeCurrency() {
        guard let currencyList = presenter?.getCurrencyList(), currencyList.count > 0,
            let selectedIndex = presenter?.selectedCurrencyIndex() else {
                return
        }

        if let currencyPicker = ActionSheetPickerView.createPicker(selectedIndex: selectedIndex,
                                                                   options: currencyList,
                                                                   completionBlock: {[weak self] (_, value) in
                                                                    guard let strongSelf = self else {
                                                                        return
                                                                    }
                                                                    strongSelf.presenter?.didChangeCurency(currencyCode: value)
        } ) {
            navigationController?.present(currencyPicker, animated: true)
        }
    }
}

private extension CheckoutView {
    struct Constants {
        static let cancelButtonTitle = "Cancel"
        static let alertActionTitle = "Close"
        static let screenTitle = "Checkout"
    }

    func setupNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: Constants.cancelButtonTitle, style: .plain, target: self, action: #selector(didSelectCancel))
    }

    @objc func didSelectCancel() {
        dismiss(animated: true)
    }
}

extension CheckoutView: CheckoutInput {
    func displayBasketInformation(with numberOfItems: String, totalCost: String) {
        self.totalAmountOfMoney.text = "Basket Subtotal (\(numberOfItems)): \(totalCost)"
    }

    func displayError(with message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: Constants.alertActionTitle, style: .cancel) { _ in
                alertController.dismiss(animated: true)
            })

            self.present(alertController, animated: true)
        }
    }
}

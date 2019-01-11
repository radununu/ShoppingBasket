//
//  ProductListCell.swift
//  ShoppingBasket
//

import UIKit

protocol ProductCellOutput {
    func didChangeValueIn(cell: ProductListCell, value: Int)
}

class ProductListCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    var delegate: ProductCellOutput?    
    
    func configureCellWith(model product: Product, delegate: ProductCellOutput) {
        self.delegate = delegate
        titleLabel.text = product.name
        detailLabel.text = NumberFormatter.formattedPrice(with: product.price, currencyCode: Currency.defaultCurrency) + " " + product.details
    }
    
    @IBAction func didChangeQuantity(_ sender: UIStepper) {
        quantityLabel.text = String(Int(sender.value))
        delegate?.didChangeValueIn(cell: self, value: Int(sender.value))
    }
}

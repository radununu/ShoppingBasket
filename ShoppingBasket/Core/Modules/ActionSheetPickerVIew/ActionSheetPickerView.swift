//
//  ActionSheetPickerView.swift
//  ShoppingBasket
//


import UIKit

typealias PickerElements = (selectedIndex: Int, options: [String])
typealias PickerSelection = (selectedIndex: Int, selectedTitle: String)

class ActionSheetPickerView: UIViewController {
    @IBOutlet private weak var pickerView: UIPickerView!
    @IBOutlet private weak var cancelButton: UIBarButtonItem!
    @IBOutlet private weak var selectButton: UIBarButtonItem!
    
    var completionBlock: ((PickerSelection) -> ())?
    var selectedIndex = 0
    private var options = [String]()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pickerView.selectRow(selectedIndex, inComponent: 0, animated: true)
    }
    
    @IBAction func chooseSelectedValue() {
        dismiss(animated: true) { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.completionBlock?((strongSelf.selectedIndex, strongSelf.options[strongSelf.selectedIndex]))
        }
    }
    
    @IBAction func cancelAction() {
        dismiss(animated: true)
    }
}

extension ActionSheetPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = row
    }
}

extension ActionSheetPickerView {

    static func createPicker(selectedIndex: Int, options: [String], completionBlock:@escaping (PickerSelection) -> ()) -> ActionSheetPickerView? {
        let storyBoard = UIStoryboard(name: "ActionSheetPickerView", bundle: nil)
        guard let pickerView = storyBoard.instantiateInitialViewController() as? ActionSheetPickerView else {
            return nil
        }
        
        pickerView.completionBlock = completionBlock
        pickerView.options = options
        pickerView.selectedIndex = selectedIndex
        pickerView.modalPresentationStyle = .overCurrentContext
        pickerView.modalTransitionStyle = .crossDissolve
        return pickerView
    }
}

//
//  ProductTemplatePickerTextField.swift
//  talabyeh
//
//  Created by Hussein Work on 18/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit

class ProductTemplatePickerTextField: PickerTextField {
    
    var pickerViewController: ProductTemplatesPickerViewController?
    
    var filterCategory: SubCategory?
    
    var product: ProductTemplate? = nil {
        didSet {
            self.text = product?.name

            // text field does not call the notification UITextField.textDidChangeNotification upon changing the text manually, so we need to call this to insure receivers stay up to date
            NotificationCenter.default.post(name: UITextField.textDidChangeNotification, object: self)
        }
    }

    override func setup() {
        super.setup()
        
        isSeparatorHidden = true
        isImageViewHidden = true
        placeholder = "Select Product Type"
        
        onTap = { [unowned self] in
            self.presentPicker()
        }
    }
    
    func presentPicker(){
        pickerViewController = ProductTemplatesPickerViewController()
        pickerViewController?.delegate = self
        pickerViewController?.selectedProduct = self.product
        pickerViewController?.filterCategory = self.filterCategory

        if let topVC = UIApplication.topViewController() {
            topVC.present(pickerViewController!.embededInNavigationController(style: .secondary, autoShowsCloseButton: true, showsNavigationBar: true), animated: true, completion: nil)
        }
    }
}

extension ProductTemplatePickerTextField: ProductTemplatesPickerViewControllerDelegate {
    func productTemplatesPickerViewController(_ sender: ProductTemplatesPickerViewController, didFinishWith productTempalte: ProductTemplate) {
        self.product = productTempalte
    }
}

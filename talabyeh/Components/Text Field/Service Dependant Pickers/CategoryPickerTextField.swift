//
//  CategoryPickerTextField.swift
//  talabyeh
//
//  Created by Hussein Work on 20/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class CategoryPickerTextField: PickerTextField {
    
    var pickerController: CategoryPickerController?
    var categories: [CategoryItem] = [] {
        didSet {
            self.text = categories.map { $0.title }.joined(separator: ", ")
        }
    }
    
    override func setup() {
        super.setup()
        
        isSeparatorHidden = true
        imageView.image = UIImage(named: "pin_small")
        
        onTap = { [unowned self] in
            // pick a location  :)
            self.presentPicker()
        }
    }
    
    func presentPicker(){
        pickerController = .init(selectedCategories: self.categories, delegate: self)
        
        if let topVC = UIApplication.topViewController() {
            pickerController?.present(on: topVC)
        }
    }
}

extension CategoryPickerTextField: CategoryPickerControllerDelegate {
    func categoryPickerController(_ sender: CategoryPickerController, didFinishWith categories: [CategoryItem]) {
        self.categories = categories
    }
}

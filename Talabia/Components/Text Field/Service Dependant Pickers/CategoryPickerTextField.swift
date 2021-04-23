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
    var categories: [SubCategory] = [] {
        didSet {
            self.text = categories.map { ($0.title) }.joined(separator: ", ")

            // text field does not call the notification UITextField.textDidChangeNotification upon changing the text manually, so we need to call this to insure receivers stay up to date
            NotificationCenter.default.post(name: UITextField.textDidChangeNotification, object: self)
        }
    }

    override func setup() {
        super.setup()

        isSeparatorHidden = true
        imageView.image = UIImage(named: "picker_dropdown")

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
    func categoryPickerController(_ sender: CategoryPickerController, didFinishWith categories: [SubCategory]) {
        self.categories = categories
    }
}

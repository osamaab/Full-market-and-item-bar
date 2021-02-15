//
//  CityPickerTextField.swift
//  talabyeh
//
//  Created by Hussein Work on 14/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit

class CityPickerTextField: PickerTextField {
    
    var cityPickerViewController: CityPickerViewController?
    
    var city: CityItem? = nil {
        didSet {
            self.text = city?.title

            // text field does not call the notification UITextField.textDidChangeNotification upon changing the text manually, so we need to call this to insure receivers stay up to date
            NotificationCenter.default.post(name: UITextField.textDidChangeNotification, object: self)
        }
    }
    
    override func setup() {
        super.setup()

        isSeparatorHidden = true
        imageView.image = UIImage(named: "pin_small")

        onTap = { [unowned self] in
            self.presentPicker()
        }
    }

    func presentPicker(){
        cityPickerViewController = CityPickerViewController()
        cityPickerViewController?.delegate = self
        cityPickerViewController?.selectionMode = .single
        
        if let item = self.city {
            cityPickerViewController?.selectedOptions = [item]
        }

        if let topVC = UIApplication.topViewController() {
            topVC.present(cityPickerViewController!.embededInNavigationController(style: .secondary, autoShowsCloseButton: true, showsNavigationBar: true), animated: true, completion: nil)
        }
    }
}

extension CityPickerTextField: CityPickerViewControllerDelegate {
    func cityPickerViewController(_ sender: CityPickerViewController, didFinishWith options: [CityItem]) {
        self.city = options.first
        sender.dismiss(animated: true, completion: nil)
    }
}

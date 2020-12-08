//
//  LocationPickerTextField.swift
//  talabyeh
//
//  Created by Hussein Work on 20/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class LocationPickerTextField: PickerTextField {
    
    var pickerController: LocationPickerController?
    var location: PickedLocation? {
        didSet {
            self.text = location?.address
            
            // text field does not call the notification UITextField.textDidChangeNotification upon changing the text manually, so we need to call this to insure receivers stay up to date
            NotificationCenter.default.post(name: UITextField.textDidChangeNotification, object: self)
        }
    }
    
    var onPick: ((Location?) -> Void)?
    
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
        pickerController = .init(title: self.placeholder ?? "", location: location, delegate: self)
        
        if let topVC = UIApplication.topViewController() {
            pickerController?.present(on: topVC)
        }
    }
}

extension LocationPickerTextField: LocationPickerControllerDelegate {
    func locationPickerController(_ sender: LocationPickerController, didFinishWith location: PickedLocation?) {
        self.location = location
        onPick?(location)
    }
}

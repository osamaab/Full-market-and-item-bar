//
//  CreditCardNumberTextField.swift
//  talabyeh
//
//  Created by Hussein Work on 17/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import CardScanner

class CreditCardNumberTextField: ValidationTextField {
    
    let imageView: UIImageView = .init()

    fileprivate func updateInsets(){
        let originalInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        var modifited = originalInset
        
        let padding: CGFloat = 20
        
        if isRTL {
            modifited.left += padding
        } else {
            modifited.right += padding
        }
        
        self.inset = modifited
    }
    
    override func setup() {
        super.setup()
        
        
        self.keyboardType = .decimalPad
        self.textContentType = .creditCardNumber
        self.validator = PaymentCardValidator()
        
        // add the image view and it's separator
        imageView.tintColor = DefaultColorsProvider.fieldBorder
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "camera")
        
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.width(20).height(20).centerVertically().trailing(15)
        
        // modify the insets so the text would not go through the icon
        self.updateInsets()
        
        imageView.addAction {
            // present a card scanner :)
            let scannerView = CardScanner.getScanner { card, date, cvv in
                self.text = card
            }
           
            UIApplication.topViewController()?.present(scannerView, animated: true, completion: nil)
        }
    }
}

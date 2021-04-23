//
//  NumbersTextFields.swift
//  talabyeh
//
//  Created by Hussein Work on 15/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class NumbersTextField: ValidationTextField, UITextFieldDelegate {
    
    var _acceptableCharacters: String {
        if allowsDicimals {
            return "0123456789."
        } else {
            return "0123456789"
        }
    }
    
    var maxDigitsCount: Int
    var allowsDicimals: Bool = true
    
    init(maxDigitsCount: Int, allowsDicimals: Bool = false) {
        self.maxDigitsCount = maxDigitsCount
        self.allowsDicimals = allowsDicimals
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.maxDigitsCount = 10
        self.allowsDicimals = false
        super.init(coder: aDecoder)
    }
    
    override func setup(){
        super.setup()
        delegate = self
        keyboardType = .numberPad
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (string.count == 0) {
            return true
        }
        
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        
        let cs = CharacterSet(charactersIn: _acceptableCharacters)
        let filtered = string.components(separatedBy: cs).filter {  !$0.isEmpty }
        let str = filtered.joined(separator: "")

        
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= maxDigitsCount && (string != str)
    }
}

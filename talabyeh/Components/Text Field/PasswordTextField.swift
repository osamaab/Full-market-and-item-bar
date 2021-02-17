//
//  PasswordTextField.swift
//  talabyeh
//
//  Created by Hussein Work on 11/12/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class PasswordTextField: BorderedTextField {
    
    enum PasswordStrength: String {
        case strong
        case medium
        case weak
        
        var color: UIColor {
            switch self {
            case .strong:
                return DefaultColorsProvider.messageSuccess
            case .medium:
                return DefaultColorsProvider.messageNotice
            case .weak:
                return DefaultColorsProvider.messageError
            }
        }
        
        static func strength(for input: String) -> PasswordStrength {
            let strongPassword = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{8,}$")
            if strongPassword.evaluate(with: input){
                return .strong
            }
            
            let mediumPasswod = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
            if mediumPasswod.evaluate(with: input){
                return .medium
            }
            
            return .weak
        }
    }
    
    
    private var strengthText = UILabel()
    
    var showsPasswordStrength: Bool = true
    
    override func setup() {
        super.setup()
        
        isSecureTextEntry = true
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextField.textDidChangeNotification, object: self)
    }
        
    @objc func textDidChange(){
        guard let text = self.text, !text.isEmpty else {
            self.showPasswordStrengthMessage(type: nil)
            return
        }
        
        showPasswordStrengthMessage(type: PasswordStrength.strength(for: text))
    }

    func showPasswordStrengthMessage(type: PasswordStrength?) {
        guard let type = type, showsPasswordStrength else {
            strengthText.removeFromSuperview()
            return
        }
        
        strengthText.removeFromSuperview()
        subviews(strengthText)
        strengthText.text = type.rawValue.localiz()
        strengthText.textColor = type.color
        
        strengthText.trailing(16).width(60).height(20).centerVertically()
    }
}

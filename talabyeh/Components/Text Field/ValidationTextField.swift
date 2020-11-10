//
//  ValidationTextField.swift
//  talabyeh
//
//  Created by Hussein Work on 11/10/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit
import Stevia

/**
 A Text field which adds a validation feature for it's content.
 
 TODO: change the implementation
 */
class ValidationTextField: InsetedTextField {
    
    enum PasswordStrength: String {
        case Strong = "Strong"
        case Medium = "Medium"
        case Weak = "Weak"
    }

    
    private var strengthText = UILabel()
    private var errorMessageLabel = UILabel()

    public func showPasswordStrengthMessage(type: PasswordStrength) {
        strengthText.removeFromSuperview()
        subviews(strengthText)
        strengthText.text = type.rawValue.localiz()
        if type == PasswordStrength.Strong{
            strengthText.textColor = #colorLiteral(red: 0, green: 0.7843137255, blue: 0.5490196078, alpha: 1)
        }else if type == .Medium{
            strengthText.textColor = #colorLiteral(red: 0.7843137255, green: 0.7529411765, blue: 0, alpha: 1)
        }else if type == .Weak{
            strengthText.textColor = #colorLiteral(red: 0.7843137255, green: 0, blue: 0, alpha: 1)
        }
        
        strengthText.trailing(16).width(60).height(20).centerVertically()
    }
    
    public func showErrorMessage(message: String) {
        errorMessageLabel.removeFromSuperview()
        self.superview!.subviews(errorMessageLabel)
        errorMessageLabel.text = message
        errorMessageLabel.textColor = #colorLiteral(red: 0.7843137255, green: 0, blue: 0, alpha: 1)
        errorMessageLabel.leading(16).width(self.frame.size.width).height(20)
        errorMessageLabel.Top == self.Bottom //+ 5
        
        errorMessageLabel.font = .font(for: .medium, size: 14)
    }
}

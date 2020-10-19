//
//  CustomTextField.swift
//  
//
//  Created by Loai Elayan on 10/8/20.
//

import UIKit
import LanguageManager_iOS
import ValidationTextField
import Stevia

class CustomTextField: UITextField {
    
    var padding: UIEdgeInsets {
        get {
            return UIEdgeInsets(top: 0, left: paddingValue, bottom: 0, right: paddingValue)
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    @IBInspectable var paddingValue: CGFloat = 0
    
    
    @IBInspectable var borderColor: UIColor? = UIColor.clear {
        didSet {
            layer.borderColor = self.borderColor?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = self.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = self.cornerRadius
            layer.masksToBounds = self.cornerRadius > 0
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    

    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = self.cornerRadius
        self.layer.borderWidth = self.borderWidth
        self.layer.borderColor = self.borderColor?.cgColor
        
        
    }
    

    
    private var strengthText = UILabel()
    public func showPasswordStrengthMessage(type: PasswordStrength)
    {
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
    
    private var errorMessageLabel = UILabel()
    public func showErrorMessage(message: String)
    {
        errorMessageLabel.removeFromSuperview()
        self.superview!.subviews(errorMessageLabel)
        errorMessageLabel.font = LanguageManager.shared.currentLanguage == .ar ? getArabicFont(14, .regular) : getEnglishFont(14, .medium)
        errorMessageLabel.text = message
        errorMessageLabel.textColor = #colorLiteral(red: 0.7843137255, green: 0, blue: 0, alpha: 1)
        errorMessageLabel.leading(16).width(self.frame.size.width).height(20)
        errorMessageLabel.Top == self.Bottom //+ 5
    }
    
    


}


enum PasswordStrength: String {
    case Strong = "Strong"
    case Medium = "Medium"
    case Weak = "Weak"
}

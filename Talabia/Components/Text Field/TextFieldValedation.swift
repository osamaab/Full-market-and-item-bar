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
        self.maxLength = 50
        isSecureTextEntry = true
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextField.textDidChangeNotification, object: self)
    }
        
    @objc func textDidChange(){
        guard let text = self.text, !text.isEmpty else {
            self.showPasswordStrengthMessage(type: .weak)
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

class CompanyTextField: BorderedTextField {
    
    private var worningImageView = UIImageView()

    enum CompanyValedation {
        case valid
        case unValid
        
        var isValid: Bool {
            switch self {
            case .valid:
                return true
            case .unValid:
                return false
            }
        }
        static func strength(for input: String) -> CompanyValedation {
            let companyvalidator = NSPredicate(format: "SELF MATCHES %@ ", "\\A\\w{2,18}\\z")
            if companyvalidator.evaluate(with: input){
                return .valid
            }else{
                return .unValid
            }
        }
    }
    func showWorningMessage(){
        worningImageView.isHidden = false
    }
    func hideWorningMessage(){
        worningImageView.isHidden = true
    }
    override func setup() {
        super.setup()
        self.maxLength = 100
        isSecureTextEntry = false
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextField.textDidChangeNotification, object: self)
    }
    
    @objc func textDidChange(){
        guard let text = self.text, !text.isEmpty else {
            self.showWorninghMessage(type: .valid)
            return
        }
        showWorninghMessage(type: CompanyValedation.strength(for: text))
    }
    
    func showWorninghMessage(type: CompanyValedation?) {
        if type == .valid {
            hideWorningMessage()
        }else {
            showWorningMessage()
            worningImageView.removeFromSuperview()
            subviews(worningImageView)
            worningImageView.image = UIImage(named: "operation-faild")
            worningImageView.top(15).trailing(15).width(17).height(17)
        }
    }
}

class MopileTextField: BorderedTextField {
    var companySignUp : CompanySignUpViewController?
    private var worningImageView = UIImageView()
    
    enum MopileValedation {
        case valid
        case unValid
        
        var color: Bool {
            switch self {
            case .valid:
                return true
            case .unValid:
                return false
            }
        }
        static func strength(for input: String) -> MopileValedation {
            let mopilevalidator = NSPredicate(format: "SELF MATCHES %@ ", "^[0-9+]{0,1}+[0-9]{5,16}$")
            if mopilevalidator.evaluate(with: input){
                return .valid
            }else{
                return .unValid
            }
        }
    }
    func showWorningMessage(){
        worningImageView.isHidden = false
    }
    func hideWorningMessage(){
        worningImageView.isHidden = true
    }
    override func setup() {
        super.setup()
        self.maxLength = 40
        isSecureTextEntry = false
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextField.textDidChangeNotification, object: self)
    }
    
    @objc func textDidChange(){
        guard let text = self.text, !text.isEmpty else {
            self.showMopileWorninghMessage(type: .unValid)
            return
        }
        showMopileWorninghMessage(type: MopileValedation.strength(for: text))
    }
    
    func showMopileWorninghMessage(type: MopileValedation?) {
        if type == .valid {
            hideWorningMessage()

        }else {
            showWorningMessage()

            worningImageView.removeFromSuperview()
            subviews(worningImageView)
            worningImageView.image = UIImage(named: "operation-faild")
            worningImageView.top(15).trailing(15).width(17).height(17)
        }
    }
}
class WebsiteTextField: BorderedTextField {
    var companySignUp : CompanySignUpViewController?
    private var worningImageView = UIImageView()

    enum WebsiteValedation {
        case valid
        case unValid
        
        var color: Bool {
            switch self {
            case .valid:
                return true
            case .unValid:
                return false
            }
        }
        static func strength(for input: String) -> WebsiteValedation {
            let websiteValidator = NSPredicate(format: "SELF MATCHES %@ ", "((\\w|-)+)(([.]|[/])((\\w|-)+))+")
            if websiteValidator.evaluate(with: input){
                return .valid
            }else{
                return .unValid
            }
        }
    }
    func showWorningMessage(){
        worningImageView.isHidden = false
    }
    func hideWorningMessage(){
        worningImageView.isHidden = true
    }
    override func setup() {
        super.setup()
        self.maxLength = 100
        self.autocapitalizationType = .none
        isSecureTextEntry = false
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextField.textDidChangeNotification, object: self)
    }
    
    @objc func textDidChange(){
        guard let text = self.text, !text.isEmpty else {
            self.showWorninghMessage(type: .unValid)
            return
        }
        showWorninghMessage(type: WebsiteValedation.strength(for: text))
    }
    
    func showWorninghMessage(type: WebsiteValedation?) {
        if type == .valid {
            hideWorningMessage()
        }else {
            showWorningMessage()
            worningImageView.removeFromSuperview()
            subviews(worningImageView)
            worningImageView.image = UIImage(named: "operation-faild")
            worningImageView.top(15).trailing(15).width(17).height(17)
        }
    }
}

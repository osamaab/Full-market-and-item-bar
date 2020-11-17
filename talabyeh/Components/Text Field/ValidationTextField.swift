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
class ValidationTextField: BorderedTextField {
    
    private var errorMessageLabel = UILabel()
    
    var validator: ValidatorType? {
        didSet {
            self.performValidationAndShowError(for: text)
        }
    }

    var hasErrors: Bool {
        guard let validator = self.validator else {
            return false
        }
        
        return (try? validator.validated(self.text)) == nil
    }
    
    override func setup(){
        super.setup()
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextField.textDidChangeNotification, object: self)
    }
    
    @objc func textDidChange(){
        performValidationAndShowError(for: text)
    }
    
    func performValidationAndShowError(for text: String?) {
        guard let validator = self.validator else {
            return
        }
        
        let errorMessage: String?
        do {
            _ = try validator.validated(text)
            errorMessage = nil
        } catch let error as ValidationError {
            errorMessage = error.message
        } catch {
            errorMessage = error.localizedDescription
        }
        
        if let message = errorMessage {
            showErrorMessage(message: message)
        } else {
            removeErrorMessage()
        }
    }
    
    func removeErrorMessage(){
        errorMessageLabel.removeFromSuperview()
    }
    
    func showErrorMessage(message: String) {
        errorMessageLabel.removeFromSuperview()
        
        guard let superview = self.superview else {
            return
        }

        superview.subviews(errorMessageLabel)

        errorMessageLabel.text = message
        errorMessageLabel.textColor = #colorLiteral(red: 0.7843137255, green: 0, blue: 0, alpha: 1)
        errorMessageLabel.leading(16).width(self.frame.size.width).height(20)
        errorMessageLabel.Top == self.Bottom
        errorMessageLabel.font = .font(for: .medium, size: 14)
    }
}

/**
 Quiz skitch:
 - we need to validate the content using regular expression
 - validation happens when the text field is editing, and the message is shwon upon finish editing.
 */

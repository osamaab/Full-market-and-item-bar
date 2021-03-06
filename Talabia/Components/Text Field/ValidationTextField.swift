//
//  ValidationTextField.swift
//  talabyeh
//
//  Created by Hussein Work on 11/10/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

/**
 A Text field which adds a validation feature for it's content.

 TODO: change the implementation
 */
class ValidationTextField: BorderedTextField {
    
    let worningImageView = UIImageView().then{
        $0.isHidden = true
    }
    
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
        worningImageView.isHidden = true
    }
    
    @objc func textDidChange(){
        performValidationAndShowError(for: text)
      worningImageView.isHidden = false
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
        worningImageView.removeFromSuperview()
    }
    
    func showErrorMessage(message: String) {
        errorMessageLabel.removeFromSuperview()
        worningImageView.removeFromSuperview()
        
        guard let superview = self.superview else {
            return
        }

        superview.subviews(errorMessageLabel)
        subviews(worningImageView)
        errorMessageLabel.text = message
        errorMessageLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        errorMessageLabel.leading(16).width(self.frame.size.width).height(20)
        errorMessageLabel.Top == self.Bottom
        errorMessageLabel.font = .font(for: .medium, size: 14)
        worningImageView.image = UIImage(named: "operation-faild")
        worningImageView.top(15).trailing(15).width(17).height(17)

    }
}

/**
 Quiz skitch:
 - we need to validate the content using regular expression
 - validation happens when the text field is editing, and the message is shwon upon finish editing.
 */

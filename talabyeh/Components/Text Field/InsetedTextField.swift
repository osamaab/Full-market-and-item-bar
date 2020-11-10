//
//  InsetedTextField.swift
//  talabyeh
//
//  Created by Hussein Work on 11/10/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit

/**
 A custom text field that provides the feature of insetting the text inside it
 */
class InsetedTextField: UITextField {
    
    @IBInspectable var paddingValue: CGFloat = 0 {
        didSet {
            inset = .init(top: 0, left: paddingValue, bottom: 0, right: paddingValue)
        }
    }
    
    var inset: UIEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 20) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        self.inset = .init(top: 0, left: paddingValue, bottom: 0, right: paddingValue)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: inset)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: inset)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: inset)
    }
}

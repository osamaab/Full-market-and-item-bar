//
//  PickerTextField.swift
//  talabyeh
//
//  Created by Hussein Work on 11/12/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia


class PickerTextField: BorderedTextField {
    
    let imageView: UIImageView = .init()
    let separatorView: UIView = .init()
    
    var isSeparatorHidden: Bool {
        set {
            separatorView.isHidden = newValue
        } get {
            separatorView.isHidden
        }
    }
    
    override func setup() {
        // add the image view and it's separator
        addSubview(imageView)
        addSubview(separatorView)
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.backgroundColor = .brown
        separatorView.backgroundColor = .brown
        
        imageView.width(25).height(25).centerVertically().trailing(15)
        separatorView.centerVertically().height(80%).width(1)
        separatorView.Trailing == imageView.Leading - 10
        
        // modify the insets so the text would not go through the icon
        let originalInset = super.inset
        var modifited = originalInset
        
        if isRTL {
            modifited.left += 20
        } else {
            modifited.right += 20
        }
        
        self.inset = modifited
    }
    
    // disable the caret, cause the field should fire a picker
    override func caretRect(for position: UITextPosition) -> CGRect {
        .zero
    }
}

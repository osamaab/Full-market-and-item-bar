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
    
    var onTap: (() -> Void)? {
        didSet {
            if self.onTap != nil && !isButtonAdded {
                addSubview(button)
                button.fillContainer()
                
                isButtonAdded = true
            } else {
                button.removeFromSuperview()
                isButtonAdded = false
            }
        }
    }
    
    var isSeparatorHidden: Bool {
        set {
            separatorView.isHidden = newValue
        } get {
            separatorView.isHidden
        }
    }
    
    var isImageViewHidden: Bool {
        set {
            imageView.isHidden = newValue
            updateInsets()
        } get {
            imageView.isHidden
        }
    }
    
    fileprivate var isButtonAdded: Bool = false
    
    fileprivate lazy var button: UIButton = {
        // adding a button on top of the text field ( self ) prevents the input view from being shown
        let button = UIButton()
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    fileprivate func updateInsets(){
        let originalInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        var modifited = originalInset
        
        let padding: CGFloat = isImageViewHidden ? 0 : 20
        
        if isRTL {
            modifited.left += padding
        } else {
            modifited.right += padding
        }
        
        self.inset = modifited
    }
    
    override func setup() {
        super.setup()
        
        // add the image view and it's separator
        imageView.tintColor = DefaultColorsProvider.decoratorBorder
        imageView.contentMode = .scaleAspectFit
        
        separatorView.backgroundColor = DefaultColorsProvider.decoratorBorder
        
        addSubview(imageView)
        addSubview(separatorView)
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.width(20).height(20).centerVertically().trailing(15)
        separatorView.centerVertically().height(80%).width(1)
        separatorView.Trailing == imageView.Leading - 10
        
        // modify the insets so the text would not go through the icon
        self.updateInsets()
    }
    
    @objc func tapped(){
        onTap?()
    }
    
    // disable the caret, cause the field should fire a picker on it's tap ( this case happens where the user has a keyboard and text fields becomes first responder without a tap )
    override func caretRect(for position: UITextPosition) -> CGRect {
        .zero
    }
}

//
//  MarketEditProfileContentView.swift
//  talabyeh
//
//  Created by Hussein Work on 23/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class MarketEditProfileContentView: BasicViewWithSetup {
    
    let containerStackView: UIStackView = .init()
    let avatarView: ChangeAvatarView = .init()
    
    let nameTextField: BorderedTextField = .init()
    let emailTextField: BorderedTextField = .init()
    
    let phoneContainerView: UIView = .init()
    let phonePrefixTextField: BorderedTextField = .init()
    let phoneTextField: BorderedTextField = .init()
    
    let confirmButton: CircleConfirmButton = .init()
    
    override func setup() {        
        nameTextField.placeholder = "Name"
        emailTextField.placeholder = "Email"
        
        phonePrefixTextField.placeholder = "+962"
        phoneTextField.placeholder = "79*******"
        
        
        subviewsPreparedAL {
            avatarView
            containerStackView
            confirmButton
        }
        
        
        containerStackView.addingArrangedSubviews {
            nameTextField
            emailTextField
            phoneContainerView
        }
        
        phoneContainerView.subviewsPreparedAL {
            phonePrefixTextField
            phoneTextField
        }
        
        containerStackView.alignment(.fill)
            .distribution(.fillEqually)
            .spacing(15)
            .axis(.vertical)
        
        
        avatarView.centerHorizontally().top(0).width(120).height(120)
        
        containerStackView.leading(0).trailing(0)
        containerStackView.Top == avatarView.Bottom + 20
        
        confirmButton.trailing(0).bottom(0)
        confirmButton.Top == containerStackView.Bottom + 20
        
        phonePrefixTextField.width(30%).leading(0).top(0).bottom(0)
        phoneTextField.width(65%).trailing(0).top(0).bottom(0)
        
        nameTextField.height(50)
        
        confirmButton.isEnabled = false
    }
}

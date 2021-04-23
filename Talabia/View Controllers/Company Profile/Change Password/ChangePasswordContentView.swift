//
//  ChangePasswordContentView.swift
//  talabyeh
//
//  Created by Hussein Work on 15/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class ChangePasswordContentView: BasicViewWithSetup {

    let stackView: UIStackView = .init()
    
    let labelView: LabelView = .init(title: "Change Password", icon: .named("menu_password"))

    let oldPasswordField = PasswordTextField()
    let newPasswordField = PasswordTextField()
    let confirmNewPasswordField = PasswordTextField()
    
    var containerPadding: UIEdgeInsets {
        .init()
    }

    override func setup() {
        stackView.axis(.vertical)
            .alignment(.fill)
            .distribution(.fill)
            .spacing(15)
            .preparedForAutolayout()
        
        oldPasswordField.showsPasswordStrength = false

        backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        addSubview(stackView)
        stackView.bottom(containerPadding.bottom).top(containerPadding.top).leading(containerPadding.left).trailing(containerPadding.right)
        
        stackView.addingArrangedSubviews {
            labelView
            oldPasswordField
            newPasswordField
            confirmNewPasswordField
        }
        
        oldPasswordField.placeholder = "Old Password"
        newPasswordField.placeholder = "New Password"
        confirmNewPasswordField.placeholder = "Confirm New Password"

        [oldPasswordField, newPasswordField, confirmNewPasswordField].forEach {
            $0.height(50)
        }
    }
}

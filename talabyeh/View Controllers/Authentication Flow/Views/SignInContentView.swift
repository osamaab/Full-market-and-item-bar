//
//  SignInView.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/11/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class SignInContentView: BasicViewWithSetup {
    let headerView = AuthHeaderView(elements: [
        .title("Welcome to TALABIA"),
        .subtitle("Let's get started")
    ])
    
    let emailtf = ValidationTextField()
    let passwordtf = PasswordTextField()
    let signInButton = CircleConfirmButton(imageType: .arrow)
    
    var onAction: ((String, String) -> Void)?
    
    override func setup() {
        backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        subviewsPreparedAL {
            headerView
            emailtf
            passwordtf
            signInButton
        }
        
        headerView.subtitleLabel.textColor = DefaultColorsProvider.textSecondary1
        
        emailtf.validator = EmailValidatorType()
        emailtf.placeholder = "Email"
        
        passwordtf.placeholder = "Password"
        
        
        signInButton.isEnabled = true
        
        headerView.top(0).leading(20).trailing(20)
        
        emailtf.leading(20).trailing(20).height(50)
        emailtf.Top == headerView.Bottom + 35
        
        passwordtf.leading(20).trailing(20).height(50)
        passwordtf.Top == emailtf.Bottom + 15
        
        
        signInButton.trailing(20)
        signInButton.Top == passwordtf.Bottom + 35
        signInButton.bottom(25)
        
        signInButton.add(event: .touchUpInside) { [unowned self] in
            guard let username = emailtf.text,
                  let password = passwordtf.text else {
                return
            }
            
            self.onAction?(username, password)
        }
    }
}

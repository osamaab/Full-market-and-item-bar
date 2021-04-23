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
    lazy var bottomView: BottomNextButtonView = .init(title: "Sign in")
    
    var onAction: ((String, String) -> Void)?
    
    override func setup() {
        backgroundColor = DefaultColorsProvider.backgroundPrimary
        emailtf.text = ""
        passwordtf.text = ""
        subviewsPreparedAL {
            headerView
            emailtf
            passwordtf
            bottomView
        }
        
        headerView.subtitleLabel.textColor = DefaultColorsProvider.textSecondary1
        
        emailtf.validator = EmailValidatorType()
        emailtf.placeholder = "Email"
        emailtf.textContentType = .emailAddress
        emailtf.keyboardType = .emailAddress
        emailtf.autocapitalizationType = .none
        
        
        passwordtf.placeholder = "Password"
        passwordtf.showsPasswordStrength = false
        
        headerView.top(0).leading(20).trailing(20)
        headerView.height(85)
        emailtf.leading(20).trailing(20).height(50)
        emailtf.Top == headerView.Bottom
        
        passwordtf.leading(20).trailing(20).height(50)
        passwordtf.Top == emailtf.Bottom + 15
        
        bottomView.bottom(0).leading(0).trailing(0)
        
        bottomView.nextButton.add(event: .touchUpInside) { [unowned self] in
            guard let username = emailtf.text,
                  let password = passwordtf.text else {
                return
            }
            
            self.onAction?(username, password)
        }
    }
}

//
//  UnAuthenticatedStateView.swift
//  talabyeh
//
//  Created by Hussein Work on 28/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

class UnAuthenticatedStateView: BasicViewWithSetup {
    
    let containerStackView: UIStackView = .init()
    let titleLabel: UILabel = .init()
    let signInButton: RoundedButton = .init()
    let signUpButton: RoundedButton = .init()

    override func setup() {
        subviewsPreparedAL { () -> [UIView] in
            containerStackView
        }
        
        
        titleLabel.font = .font(for: .medium, size: 16)
        titleLabel.textAlignment = .center
        titleLabel.textColor = DefaultColorsProvider.textSecondary1
        
      
            
            signInButton.backgroundColor = DefaultColorsProvider.tintSecondary
            signInButton.setTitleColor(DefaultColorsProvider.tintPrimary, for: .normal)
            signInButton.titleLabel?.font = .font(for: .bold, size: 17)
            signInButton.contentEdgeInsets = .init(top: 22, left: 125, bottom: 22, right: 125)
            signInButton.layer.cornerRadius = 13
        signInButton.layer.borderWidth = 1
        signInButton.layer.borderColor = DefaultColorsProvider.tintPrimary.cgColor
        
        signUpButton.backgroundColor = .white
        signUpButton.setTitleColor(DefaultColorsProvider.tintPrimary, for: .normal)
        signUpButton.titleLabel?.font = .font(for: .bold, size: 17)
        signUpButton.contentEdgeInsets = .init(top: 22, left: 125, bottom: 22, right: 125)
        signUpButton.layer.cornerRadius = 13
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.borderColor = DefaultColorsProvider.tintPrimary.cgColor
        
        
        signInButton.setTitle("Sign In", for: .normal)
        signUpButton.setTitle("Sign Up", for: .normal)
        
        containerStackView.addingArrangedSubviews { () -> [UIView] in
            titleLabel
            signInButton
            signUpButton
        }
        
        containerStackView
            .axis(.vertical)
            .alignment(.fill)
            .spacing(16)
            
        containerStackView.setCustomSpacing(35, after: titleLabel)
        containerStackView.centerVertically()
            .leading(40).trailing(40).bottom(>=20)
    }
}

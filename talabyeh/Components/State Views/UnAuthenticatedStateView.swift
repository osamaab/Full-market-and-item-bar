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
    let signInButton: UIButton = .init()
    let signUpButton: UIButton = .init()

    override func setup() {
        subviewsPreparedAL { () -> [UIView] in
            containerStackView
        }
        
        
        titleLabel.font = .font(for: .medium, size: 16)
        titleLabel.textAlignment = .center
        titleLabel.textColor = DefaultColorsProvider.tintPrimary
        
        [signInButton, signUpButton].forEach {
            $0.backgroundColor = DefaultColorsProvider.containerBackground2
            $0.setTitleColor(DefaultColorsProvider.tintPrimary, for: .normal)
            $0.titleLabel?.font = .font(for: .medium, size: 16)
            $0.contentEdgeInsets = .init(top: 12, left: 20, bottom: 12, right: 20)
            $0.layer.cornerRadius = 6
        }
        
        signInButton.setTitle("Sign up", for: .normal)
        signUpButton.setTitle("Sign in", for: .normal)
        
        containerStackView.addingArrangedSubviews { () -> [UIView] in
            titleLabel
            signInButton
            signUpButton
        }
        
        containerStackView
            .axis(.vertical)
            .alignment(.fill)
            .spacing(15)
            
        containerStackView.setCustomSpacing(35, after: titleLabel)
        containerStackView.top(35).leading(30).trailing(30).bottom(>=20)
    }
}

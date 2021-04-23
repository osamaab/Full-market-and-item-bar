//
//  chooseSigninOrSignUpcontentView.swift
//  talabyeh
//
//  Created by Osama Abu hdba on 29/03/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import UIKit
import Stevia

class chooseSigninOrSignUpcontentView: BasicViewWithSetup {
    
    let titleLabel = UILabel().then {
        $0.font = .font(for: .regular, size: 17)
        $0.textColor = DefaultColorsProvider.textSecondary2
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.text = "Please sign up or sign in to see your items"
    }
    
    let signInButton = RoundedButton().then{
        $0.backgroundColor = DefaultColorsProvider.tintSecondary
        $0.setTitleColor(DefaultColorsProvider.tintPrimary, for: .normal)
        $0.titleLabel?.font = .font(for: .bold, size: 17)
        $0.setTitle("Sign in", for: .normal)
        
        $0.layer.borderWidth = 1
        $0.layer.borderColor = DefaultColorsProvider.tintPrimary.cgColor
        $0.contentEdgeInsets = .init(top: 11, left: 125, bottom: 11, right: 125)
    }
    
    let signUpButton = RoundedButton().then {
        $0.backgroundColor = DefaultColorsProvider.backgroundPrimary
        $0.setTitleColor(DefaultColorsProvider.tintPrimary, for: .normal)
        $0.titleLabel?.font = .font(for: .bold, size: 17)
        $0.setTitle("Sign Up", for: .normal)
        
        $0.layer.borderWidth = 1
        $0.layer.borderColor = DefaultColorsProvider.tintPrimary.cgColor
        $0.contentEdgeInsets = .init(top: 11, left: 125, bottom: 11, right: 125)
    }
    
    override func setup() {
        let containerStackView = UIStackView()
        
        
        containerStackView.alignment(.center)
            .distribution(.fill)
            .spacing(46)
            .axis(.vertical)
        
        subviewsPreparedAL {
            containerStackView
        }
        
        containerStackView.top(>=0).leading(0).centerHorizontally().centerVertically()
        
        let buttonsStacckView = UIStackView()
        
        buttonsStacckView.alignment(.fill)
            .distribution(.fillEqually)
            .spacing(16)
            .axis(.vertical)
        
        buttonsStacckView.addingArrangedSubviews {
            signInButton
            signUpButton
        }
        
        containerStackView.addingArrangedSubviews {
            titleLabel
            buttonsStacckView
        }
        

        
        .width(333)
    }
}

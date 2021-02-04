//
//  DistributorSignInContentView.swift
//  talabyeh
//
//  Created by Hussein Work on 09/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit

class DistributorSignInContentView: BasicViewWithSetup {

    let containerStackView: UIStackView = .init()
    let fieldsStackView: UIStackView = .init()
    
    let headerView: AuthHeaderView = .init(elements: [
        .title("Welcome to TALABIA"),
        .type(.distributor)
    ])
    
    let typeSegmentedControl: BigSegmentedControl = .init(items: ["Company Distributor", "Personal Distributor"])
    
    
    let emailTextField: BorderedTextField = .init()
    let passwordTextField: BorderedTextField = .init()
    
    override func setup() {
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary

        setupFields()
        setupContentView()
    }
    
    func setupContentView(){
        subviewsPreparedAL {
            containerStackView
        }
        
        containerStackView.alignment(.fill)
            .distribution(.fill)
            .spacing(10)
            .axis(.vertical)
            .preparedForAutolayout()
        
        containerStackView.addingArrangedSubviews {
            headerView
            typeSegmentedControl
            fieldsStackView
        }
        
        containerStackView.fillContainer()
    }
    
    func setupFields(){
        emailTextField.placeholder = "Email"
        passwordTextField.placeholder = "Password"
        
        fieldsStackView.alignment(.fill).axis(.vertical).distribution(.fillEqually).spacing(10).preparedForAutolayout()
        
        fieldsStackView.addingArrangedSubviews {
            emailTextField
            passwordTextField
        }
    }
}

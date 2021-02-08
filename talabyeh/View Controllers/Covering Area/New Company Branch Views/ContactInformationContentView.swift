//
//  ContactInformationContentView.swift
//  talabyeh
//
//  Created by Hussein Work on 08/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit

class ContactInformationContentView: BasicViewWithSetup {

    fileprivate var fieldsStackView = UIStackView().then {
        $0.alignment(.fill)
            .distribution(.fillEqually)
            .axis(.vertical)
            .spacing(15)
            .preparedForAutolayout()
    }

    let telephoneTextField = BorderedTextField().then {
        $0.placeholder = "Tel."
    }
    
    let faxTextField = BorderedTextField().then {
        $0.placeholder = "Fax"
    }
    
    let emailTextField = BorderedTextField().then {
        $0.placeholder = "Email"
    }
    
    override func setup() {
        backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        view.subviewsPreparedAL {
            fieldsStackView
        }
        
        fieldsStackView.fillContainer()
        fieldsStackView.addingArrangedSubviews {
            telephoneTextField
            faxTextField
            emailTextField
        }
    }
}

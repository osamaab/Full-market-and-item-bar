//
//  BasicLocationInformationContentView.swift
//  talabyeh
//
//  Created by Hussein Work on 08/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit

class BasicLocationInformationContentView: BasicViewWithSetup {

    
    fileprivate var fieldsStackView = UIStackView().then {
        $0.alignment(.fill)
            .distribution(.fillEqually)
            .axis(.vertical)
            .spacing(15)
            .preparedForAutolayout()
    }
    
    let locationTextField = LocationPickerTextField().then {
        $0.placeholder = "Location"
    }
    
    let nameTextField = BorderedTextField().then {
        $0.placeholder = "Location Name"
    }
    
    let cityTextField = BorderedTextField().then {
        $0.placeholder = "City"
    }
    
    let streetTextField = BorderedTextField().then {
        $0.placeholder = "Street"
    }
    
    let buildingTextField = BorderedTextField().then {
        $0.placeholder = "Building Name/ Number"
    }
    
    let floorTextField = BorderedTextField().then {
        $0.placeholder = "Floor"
    }
    
    let additionalInfoTextField = BorderedTextField().then {
        $0.placeholder = "Additional Directions ( Optional )"
    }
    
    override func setup() {
        backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        view.subviewsPreparedAL {
            fieldsStackView
        }
        
        fieldsStackView.fillContainer()
        fieldsStackView.addingArrangedSubviews {
            locationTextField
            nameTextField
            cityTextField
            streetTextField
            buildingTextField
            floorTextField
            additionalInfoTextField
        }
    }
}

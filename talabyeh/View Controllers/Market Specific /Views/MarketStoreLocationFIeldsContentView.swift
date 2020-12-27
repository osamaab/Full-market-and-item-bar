//
//  MarketStoreLocationFIeldsContentView.swift
//  talabyeh
//
//  Created by Hussein Work on 27/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class MarketStoreLocationFIeldsContentView: BasicViewWithSetup {
    
    let stackView: UIStackView = .init()
    
    let addressTextField: LocationPickerTextField = .init()
    let areaTextField: BorderedTextField = .init()
    let streetNameTextField: BorderedTextField = .init()
    let buildingTextField: BorderedTextField = .init()
    let floorTextField: BorderedTextField = .init()
    let additionalInfoTextField: BorderedTextField = .init()

    override func setup() {
        stackView.axis(.vertical)
            .alignment(.fill)
            .distribution(.fillEqually)
            .spacing(10)
            .preparedForAutolayout()

        backgroundColor = DefaultColorsProvider.backgroundPrimary
        addSubview(stackView)
        
        stackView.addingArrangedSubviews {
            addressTextField
            areaTextField
            streetNameTextField
            buildingTextField
            floorTextField
            additionalInfoTextField
        }
        
        
        addressTextField.placeholder = "Enter Address"
        areaTextField.placeholder = "Area"
        streetNameTextField.placeholder = "Street name"
        buildingTextField.placeholder = "Building Name/ Number"
        floorTextField.placeholder = "Floor"
        additionalInfoTextField.placeholder = "Additional Directions ( Optional )"
        
        stackView.fillContainer()
    }
}

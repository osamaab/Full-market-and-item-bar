//
//  BasicLocationInformationContentView.swift
//  talabyeh
//
//  Created by Hussein Work on 08/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit

class BasicLocationInformationContentView: BasicViewWithSetup, InputCardViewType {
    
    struct Output {
        let latitude: String
        let longitude: String
        let name: String
        let city: CityItem
        let street: String
        let building: String
        let floor: String
        let additionalInfo: String
    }

    
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
    
    let cityTextField = CityPickerTextField().then {
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
    
    func validateAndReturnData() throws -> Output {
        guard let location = self.locationTextField.location,
              let name = self.nameTextField.text,
              let city = self.cityTextField.city,
              let street = self.streetTextField.text,
              let building = self.buildingTextField.text,
              let floor = self.floorTextField.text else {
            
            throw InputCardViewValidationError.missingFields
        }
              
        let additionalField = self.additionalInfoTextField.text ?? ""
        
        let newOutput = Output(latitude: "\(location.coordinate.latitude)",
                               longitude: "\(location.coordinate.longitude)",
                               name: name,
                               city: city,
                               street: street,
                               building: building,
                               floor: floor, additionalInfo: additionalField)
        return newOutput
    }
}

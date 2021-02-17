//
//  NewResellerStoreLocationContentView.swift
//  talabyeh
//
//  Created by Hussein Work on 15/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit

class NewResellerStoreLocationContentView: BasicViewWithSetup, InputCardViewType {

    struct Output {
        let latitude: String
        let longitude: String
        let name: String
        let city: CityItem
        let street: String
        let building: String
        let floor: String
        let additionalInfo: String
        let startWeekday: Weekday
        let endWeekday: Weekday
        let firstTime: String
        let endTime: String
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
    
    let workingDaysTextField = WeekdaysRangePickerTextField().then {
        $0.placeholder = "Working Days"
    }
    
    let workingTimesTextField = TimeRangePickerTextField().then {
        $0.placeholder = "Working Hours"
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
            workingDaysTextField
            workingTimesTextField
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
        
        guard let startWeekday = self.workingDaysTextField.selectedFirstWeekday,
              let endWeekday = self.workingDaysTextField.selectedEndWeekday,
              let firstTime = self.workingTimesTextField.selectedFirstTime,
              let endTime = self.workingTimesTextField.selectedEndTime else {
            
            throw InputCardViewValidationError.missingFields
        }
              
        let additionalField = self.additionalInfoTextField.text ?? ""
        
        let newOutput = Output(latitude: "\(location.coordinate.latitude)",
                               longitude: "\(location.coordinate.longitude)",
                               name: name,
                               city: city,
                               street: street,
                               building: building,
                               floor: floor, additionalInfo: additionalField,
                               startWeekday: startWeekday,
                               endWeekday: endWeekday,
                               firstTime: firstTime,
                               endTime: endTime)
        return newOutput
    }
}

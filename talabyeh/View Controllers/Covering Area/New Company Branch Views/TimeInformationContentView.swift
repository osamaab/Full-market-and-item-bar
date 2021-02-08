//
//  TimeInformationContentView.swift
//  talabyeh
//
//  Created by Hussein Work on 08/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit

class TimeInformationContentView: BasicViewWithSetup {
    
    fileprivate var fieldsStackView = UIStackView().then {
        $0.alignment(.fill)
            .distribution(.fillEqually)
            .axis(.vertical)
            .spacing(15)
            .preparedForAutolayout()
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
            workingDaysTextField
            workingTimesTextField
        }
    }
}

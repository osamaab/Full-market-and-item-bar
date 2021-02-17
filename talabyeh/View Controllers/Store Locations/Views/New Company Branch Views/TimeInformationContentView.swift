//
//  TimeInformationContentView.swift
//  talabyeh
//
//  Created by Hussein Work on 08/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit

class TimeInformationContentView: BasicViewWithSetup, InputCardViewType {
    
    struct Output {
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
    
    func validateAndReturnData() throws -> Output {
        guard let startWeekday = self.workingDaysTextField.selectedFirstWeekday,
              let endWeekday = self.workingDaysTextField.selectedEndWeekday,
              let firstTime = self.workingTimesTextField.selectedFirstTime,
              let endTime = self.workingTimesTextField.selectedEndTime else {
            
            throw InputCardViewValidationError.missingFields
        }
        
        return Output(startWeekday: startWeekday, endWeekday: endWeekday, firstTime: firstTime, endTime: endTime)
    }
}

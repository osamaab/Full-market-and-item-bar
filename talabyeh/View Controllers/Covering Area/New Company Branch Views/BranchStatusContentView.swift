//
//  BranchStatusContentView.swift
//  talabyeh
//
//  Created by Hussein Work on 08/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

class BranchStatusContentView: BasicViewWithSetup {

    fileprivate var fieldsStackView = UIStackView().then {
        $0.alignment(.fill)
            .distribution(.fill)
            .axis(.vertical)
            .spacing(15)
            .preparedForAutolayout()
    }
    
    
    fileprivate let openStatusView = StatusOptionView().then {
        $0.titleLabel.text = "Open"
        $0.imageView.image = UIImage(named: "status_open")
    }
    
    fileprivate let closedStatusView = StatusOptionView().then {
        $0.titleLabel.text = "Close"
        $0.imageView.image = UIImage(named: "status_closed")
    }
    
    let daysTextField = WeekdaysRangePickerTextField().then {
        $0.placeholder = "Closing Days"
    }
    
    let reasonTextView = TextView().then {
        $0.placeholder = "Reason"
    }
    
    override func setup() {
        backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        view.subviewsPreparedAL {
            fieldsStackView
        }
        
        fieldsStackView.fillContainer()
        fieldsStackView.addingArrangedSubviews {
            openStatusView
            closedStatusView
            daysTextField
            reasonTextView
        }
        
        reasonTextView.height(150)
    }
}

private class StatusOptionView: BasicViewWithSetup {
    
    let imageView: UIImageView = .init()
    let titleLabel: UILabel = .init()
    let checkboxView: CheckboxView = .init()
    
    override func setup(){
        backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        imageView.contentMode = .scaleAspectFit
        
        
        titleLabel.font = .font(for: .medium, size: 16)
        titleLabel.textColor = DefaultColorsProvider.tintPrimary


        subviewsPreparedAL {
            imageView
            titleLabel
            checkboxView
        }
        
        
        titleLabel.centerVertically()
        imageView.leading(20).height(30).width(30).centerVertically()
        titleLabel.Leading == imageView.Trailing + 8
        checkboxView.trailing(20).height(25).width(25).centerVertically()
        checkboxView.top(0)
    }
}

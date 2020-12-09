//
//  NewDistributerViewController+Cards.swift
//  talabyeh
//
//  Created by Hussein Work on 15/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class NDPersonalInformationContentView: BasicViewWithSetup {
    
    let fieldsStackView: UIStackView = .init()
    let pickersStackView: UIStackView = .init()
    
    let nameTextfield = BorderedTextField(frame: .zero)
    let emailTextField = BorderedTextField(frame: .zero)
    let mobileTextField = NumbersTextField(maxDigitsCount: 10)
    let passwordTextField = PasswordTextField()
    
    let personalIDPickerView = PickerPlaceholderView(title: "Personal ID", image: UIImage(named: "camera"))
    let drivingLicensePickerView = PickerPlaceholderView(title: "Driving License", image: UIImage(named: "camera"))

    
    override func setup() {
        nameTextfield.placeholder = "Full name"
        emailTextField.placeholder = "Email"
        mobileTextField.placeholder = "Mobile Number"
        passwordTextField.placeholder = "Password"
        
        nameTextfield.height(45)
        
        
        fieldsStackView.addingArrangedSubviews {
            nameTextfield
            emailTextField
            mobileTextField
            passwordTextField
        }
        
        pickersStackView.addingArrangedSubviews {
            personalIDPickerView
            drivingLicensePickerView
        }
        
        fieldsStackView.axis(.vertical).spacing(8).distribution(.fillEqually).alignment(.fill).preparedForAutolayout()
        pickersStackView.axis(.horizontal).spacing(8).distribution(.fillEqually).alignment(.fill).preparedForAutolayout()
        
        let containerStackView = UIStackView()
        containerStackView.addingArrangedSubviews {
            fieldsStackView
            pickersStackView
        }
        
        containerStackView.axis(.vertical).spacing(15).alignment(.fill).distribution(.fill).preparedForAutolayout()
        
        addSubview(containerStackView)
        containerStackView.fillContainer()
    }
}

class NDCarInformationContentView: BasicViewWithSetup {
   
    let pickersStackView: UIStackView = .init()
    
    let picturesPickerView = PickerPlaceholderView(title: "Car Pictures", image: UIImage(named: "camera"))
    let licensePickerView = PickerPlaceholderView(title: "Car license", image: UIImage(named: "camera"))

    override func setup() {
        pickersStackView.addingArrangedSubviews {
            picturesPickerView
            licensePickerView
        }
        
        pickersStackView.axis(.horizontal).spacing(8).distribution(.fillEqually).alignment(.fill).preparedForAutolayout()
        
        addSubview(pickersStackView)
        pickersStackView.fillContainer()
    }
}

class NDDeliveryAreaContentView: BasicViewWithSetup {
    
    let locationTextField: PickerTextField = .init()
    
    override func setup() {
        locationTextField.placeholder = "Location"
        locationTextField.imageView.image = UIImage(named: "pin_small")
        locationTextField.height(45)
        locationTextField.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(locationTextField)
        locationTextField.fillContainer()
    }
}

class NDAvailabilityContentView: BasicViewWithSetup {
    let datesTextField: WeekdaysRangePickerTextField = .init()
    let timesTextField: TimeRangePickerTextField = .init()
    
    let fieldsStackView: UIStackView = .init()

    
    override func setup() {
        datesTextField.height(45)
        
        datesTextField.placeholder = "Dates"
        datesTextField.imageView.image = UIImage(named: "calendar_small")
        
        timesTextField.placeholder = "Times"
        timesTextField.imageView.image = UIImage(named: "clock_small")
        
        fieldsStackView.addingArrangedSubviews {
            datesTextField
            timesTextField
        }
        
        fieldsStackView.axis(.vertical).spacing(8).distribution(.fillEqually).alignment(.fill).preparedForAutolayout()

        addSubview(fieldsStackView)
        fieldsStackView.fillContainer()
    }
}

class NDMoneyDistributionContentView: BasicViewWithSetup {
    
    let fieldsStackView: UIStackView = .init()
    let horizontalStackView: UIStackView = .init()

    let nameTextField: BorderedTextField = .init()
    let numberTextField: CreditCardNumberTextField = .init()
    
    let monthTextField: MonthPickerTextField = .init()
    let yearTextField: YearPickerTextField = .init()
    let cvvTextField: NumbersTextField = .init(maxDigitsCount: 3)
    
    override func setup() {
        nameTextField.placeholder = "Card holder name"
        numberTextField.placeholder = "Card number"
        monthTextField.placeholder = "Month"
        yearTextField.placeholder = "Year"
        cvvTextField.placeholder = "CVV number"
        
        
        monthTextField.isSeparatorHidden = true
        monthTextField.isImageViewHidden = true
        yearTextField.isSeparatorHidden = true
        monthTextField.isImageViewHidden = true
        
        yearTextField.inset = .init(top: 0, left: 10, bottom: 0, right: 10)
        monthTextField.inset = .init(top: 0, left: 10, bottom: 0, right: 10)
        cvvTextField.inset = .init(top: 0, left: 10, bottom: 0, right: 10)
        
        yearTextField.setContentCompressionResistancePriority(.required, for: .horizontal)
        cvvTextField.setContentCompressionResistancePriority(.required, for: .horizontal)
        cvvTextField.setContentHuggingPriority(UILayoutPriority(240), for: .horizontal)
        
        

        nameTextField.height(45)
        
        horizontalStackView.addingArrangedSubviews {
            monthTextField
            yearTextField
            cvvTextField
        }
        
        fieldsStackView.addingArrangedSubviews {
            nameTextField
            numberTextField
            horizontalStackView
        }
        
        
        horizontalStackView.axis(.horizontal).spacing(8).alignment(.fill).preparedForAutolayout()
        fieldsStackView.axis(.vertical).spacing(8).distribution(.fillEqually).alignment(.fill).preparedForAutolayout()
        
        addSubview(fieldsStackView)
        fieldsStackView.fillContainer()
    }
}


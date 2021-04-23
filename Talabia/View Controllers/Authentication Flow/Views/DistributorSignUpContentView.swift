//
//  DistributorSignUpView.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/21/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class DistributorSignUpContentView: BasicViewWithSetup {
    
    let containerStackView: UIStackView = .init()
    let fieldsStackView: UIStackView = .init()
    let pickersContainerStackView: UIStackView = .init()

    let headerView: AuthHeaderView = .init(elements: [
        .title("Welcome to TALABIA"),
        .subtitle("Register As A Distributor"),
        .type(.distributor)
    ])
    
    
    let firstNametf = ValidationTextField()
    let passwordtf = PasswordTextField()
    let emailtf = ValidationTextField()
    let nationalNumbertf = ValidationTextField()
    let mobileNumbertf = NumbersTextField(maxDigitsCount: 10, allowsDicimals: false)
    let carType = ChoicesPickerTextField<CarType>(choices: [])

    
    let personalPictureView = PickerPlaceholderView(title: "Car Picture", image: UIImage(named: "picker_image"))
    let civilIDPictureView = PickerPlaceholderView(title: "Cart License Picture", image: UIImage(named: "picker_image"))
//    let coverageLocationsView = PickerPlaceholderView(title: "Coverage locations", image: UIImage(named: "picker_location"))
//    let categoryView = PickerPlaceholderView(title: "Category", image: UIImage(named: "picker_category"))
    
    
    override func setup() {
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary

        setupFields()
        setupPickers()
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
            fieldsStackView
            pickersContainerStackView
        }
        
        containerStackView.fillContainer()
    }
    
    func setupFields(){
        firstNametf.placeholder = "Name"
        passwordtf.placeholder = "Password"
        emailtf.placeholder = "Email"
        nationalNumbertf.placeholder = "National Number"
        mobileNumbertf.placeholder = "Mobile"
        carType.placeholder = "Car Type"
        
        carType.isImageViewHidden = true
        carType.isSeparatorHidden = true
        
        fieldsStackView.alignment(.fill).axis(.vertical).distribution(.fillEqually).spacing(10).preparedForAutolayout()
        
        fieldsStackView.addingArrangedSubviews {
            firstNametf
            passwordtf
            emailtf
            nationalNumbertf
            mobileNumbertf
            carType
        }
    }
    
    func setupPickers(){
        [personalPictureView, civilIDPictureView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let topStack = UIStackView()
        topStack.axis(.horizontal).alignment(.fill).distribution(.fillEqually).spacing(15).preparedForAutolayout()
        
        let bottomStack = UIStackView()
        bottomStack.axis(.horizontal).alignment(.fill).distribution(.fillEqually).spacing(15).preparedForAutolayout()

        topStack.arrangedSubviews([personalPictureView, civilIDPictureView])
//        bottomStack.arrangedSubviews([coverageLocationsView, categoryView])
        
        pickersContainerStackView.alignment(.fill).axis(.vertical).distribution(.fillEqually).spacing(15).preparedForAutolayout()
        
        pickersContainerStackView.arrangedSubviews([topStack])
    }
}

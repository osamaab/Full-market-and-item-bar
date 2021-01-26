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
        .type(.distributor)
    ])
    
    let typeSegmentedControl: BigSegmentedControl = .init(items: ["Company Distributor", "Personal Distributor"])
    
    let firstNametf = BorderedTextField()
    let passwordtf = BorderedTextField()
    let emailtf = BorderedTextField()
    let mobileNumbertf = BorderedTextField()
    let carType = BorderedTextField()

    
    let personalPictureView = PickerPlaceholderView(title: "Personal Picture", image: UIImage(named: "picker_image"))
    let civilIDPictureView = PickerPlaceholderView(title: "Civil ID Picture", image: UIImage(named: "picker_image"))
    let coverageLocationsView = PickerPlaceholderView(title: "Coverage locations", image: UIImage(named: "picker_location"))
    let categoryView = PickerPlaceholderView(title: "Category", image: UIImage(named: "picker_category"))
    
    
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
            typeSegmentedControl
            fieldsStackView
            pickersContainerStackView
        }
        
        containerStackView.fillContainer()
    }
    
    func setupFields(){
        firstNametf.placeholder = "Name"
        passwordtf.placeholder = "Password"
        emailtf.placeholder = "Email"
        mobileNumbertf.placeholder = "Mobile"
        carType.placeholder = "Car Type"
        
        fieldsStackView.alignment(.fill).axis(.vertical).distribution(.fillEqually).spacing(10).preparedForAutolayout()
        
        fieldsStackView.addingArrangedSubviews {
            firstNametf
            passwordtf
            emailtf
            mobileNumbertf
            carType
        }
    }
    
    func setupPickers(){
        [personalPictureView, civilIDPictureView, coverageLocationsView, categoryView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let topStack = UIStackView()
        topStack.axis(.horizontal).alignment(.fill).distribution(.fillEqually).spacing(15).preparedForAutolayout()
        
        let bottomStack = UIStackView()
        bottomStack.axis(.horizontal).alignment(.fill).distribution(.fillEqually).spacing(15).preparedForAutolayout()

        topStack.arrangedSubviews([personalPictureView, civilIDPictureView])
        bottomStack.arrangedSubviews([coverageLocationsView, categoryView])
        
        pickersContainerStackView.alignment(.fill).axis(.vertical).distribution(.fillEqually).spacing(15).preparedForAutolayout()
        
        pickersContainerStackView.arrangedSubviews([topStack, bottomStack])
    }
}

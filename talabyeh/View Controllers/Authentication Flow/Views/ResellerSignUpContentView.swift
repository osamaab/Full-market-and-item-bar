//
//  ResellerSignUpContentView.swift
//  talabyeh
//
//  Created by Hussein Work on 04/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit

class ResellerSignUpContentView: BasicViewWithSetup {

    let containerStackView: UIStackView = .init()
    let fieldsStackView: UIStackView = .init()
    let pickersContainerStackView: UIStackView = .init()

    let nametf = ValidationTextField()
    let passwordtf = PasswordTextField()
    let emailtf = ValidationTextField()
    let nationalNumbertf = ValidationTextField()
    let telephonetf = ValidationTextField()

    let licenceView = PickerPlaceholderView(title: "Commercial license", image: UIImage(named: "picker_image"))
    let storeImageView = PickerPlaceholderView(title: "Store Image", image: UIImage(named: "picker_image"))
    let storeLocationView = PickerPlaceholderView(title: "Store Location", image: UIImage(named: "picker_location"))
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
            fieldsStackView
            pickersContainerStackView
        }
        
        containerStackView.fillContainer()
    }
    
    func setupFields(){
        nametf.placeholder = "Store Name"
        passwordtf.placeholder = "Password"
        emailtf.placeholder = "Email"
        nationalNumbertf.placeholder = "Facility National Number"
        telephonetf.placeholder = "Telephone"
        
        fieldsStackView.alignment(.fill).axis(.vertical).distribution(.fillEqually).spacing(10).preparedForAutolayout()
        
        fieldsStackView.addingArrangedSubviews {
            nametf
            passwordtf
            emailtf
            nationalNumbertf
            telephonetf
        }
    }
    
    func setupPickers(){
        [storeImageView, licenceView, storeLocationView, categoryView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let topStack = UIStackView()
        topStack.axis(.horizontal).alignment(.fill).distribution(.fillEqually).spacing(15).preparedForAutolayout()
        
        let bottomStack = UIStackView()
        bottomStack.axis(.horizontal).alignment(.fill).distribution(.fillEqually).spacing(15).preparedForAutolayout()

        topStack.arrangedSubviews([licenceView, storeImageView])
        bottomStack.arrangedSubviews([storeLocationView, categoryView])
        
        pickersContainerStackView.alignment(.fill).axis(.vertical).distribution(.fillEqually).spacing(15).preparedForAutolayout()
        
        pickersContainerStackView.arrangedSubviews([topStack, bottomStack])
    }
}

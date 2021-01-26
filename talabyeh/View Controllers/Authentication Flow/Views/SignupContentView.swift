//
//  SignUpWizardView.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/7/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class SignupContentView: BasicViewWithSetup {
    
    
    let containerStackView: UIStackView = .init()
    let fieldsStackView: UIStackView = .init()
    let pickersContainerStackView: UIStackView = .init()

    let companytf = ValidationTextField()
    let passwordtf = PasswordTextField()
    let emailtf = ValidationTextField()
    let nationalNumbertf = ValidationTextField()
    let telephonetf = ValidationTextField()
    
    
    let comLicenceView = PickerPlaceholderView(title: "Commercial license", image: UIImage(named: "picker_image"))
    let companyLogoView = PickerPlaceholderView(title: "Company logo", image: UIImage(named: "picker_image"))
    let companyLocationView = PickerPlaceholderView(title: "Company Location", image: UIImage(named: "picker_location"))
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
        companytf.placeholder = "Company Name"
        passwordtf.placeholder = "Password"
        emailtf.placeholder = "Email"
        nationalNumbertf.placeholder = "Facility National Number"
        telephonetf.placeholder = "Telephone"
        
        fieldsStackView.alignment(.fill).axis(.vertical).distribution(.fillEqually).spacing(10).preparedForAutolayout()
        
        fieldsStackView.addingArrangedSubviews {
            companytf
            passwordtf
            emailtf
            nationalNumbertf
            telephonetf
        }
    }
    
    func setupPickers(){
        [comLicenceView, companyLogoView, companyLocationView, categoryView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let topStack = UIStackView()
        topStack.axis(.horizontal).alignment(.fill).distribution(.fillEqually).spacing(15).preparedForAutolayout()
        
        let bottomStack = UIStackView()
        bottomStack.axis(.horizontal).alignment(.fill).distribution(.fillEqually).spacing(15).preparedForAutolayout()

        topStack.arrangedSubviews([comLicenceView, companyLogoView])
        bottomStack.arrangedSubviews([companyLocationView, categoryView])
        
        pickersContainerStackView.alignment(.fill).axis(.vertical).distribution(.fillEqually).spacing(15).preparedForAutolayout()
        
        pickersContainerStackView.arrangedSubviews([topStack, bottomStack])
    }
}

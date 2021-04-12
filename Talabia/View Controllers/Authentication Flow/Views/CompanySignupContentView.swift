//
//  SignUpWizardView.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/7/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class CompanySignupContentView: BasicViewWithSetup {
    
    
    let containerStackView: UIStackView = .init()
    let fieldsStackView: UIStackView = .init()
    let pickersContainerStackView: UIStackView = .init()
    let worningImageView: UIImageView = .init()

    let companytf = CompanyTextField()
    let passwordtf = PasswordTextField()
    let emailtf = ValidationTextField()
    let nationalNumbertf = ValidationTextField()
    let telephonetf = MopileTextField()
    let companyWebsite = WebsiteTextField()
    
    
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
        telephonetf.placeholder = "Mobile Number"
        companyWebsite.placeholder = "Website"
        
        
        fieldsStackView.alignment(.fill).axis(.vertical).distribution(.fillEqually).spacing(10).preparedForAutolayout()
        
        fieldsStackView.addingArrangedSubviews {
            companytf
            passwordtf
            emailtf
            nationalNumbertf
            telephonetf
            companyWebsite
        }
    }
    
    func setupPickers(){
        [comLicenceView, companyLogoView, companyLocationView, categoryView,worningImageView].forEach {
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
    
        categoryView.isHidden = true
        worningImageView.image = UIImage(named: "operation-faild")
        worningImageView.isHidden = false
        companyLogoView.addSubview(worningImageView)
        worningImageView.top(15).trailing(15).width(17).height(17)

    }
}

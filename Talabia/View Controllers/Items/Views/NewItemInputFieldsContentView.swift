//
//  NewItemInputFieldsContentView.swift
//  talabyeh
//
//  Created by Hussein Work on 21/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

/**
 Requirements:
 - ChoicesPicker Text Field
 - ImagesPicker View
 - Price Text Field
 */
class NewItemInputFieldsContentView: BasicViewWithSetup {
    
    
    let containerStackView: UIStackView = .init()
    let titleLabel: UILabel = .init()
    let imagesPickerView: ImagesPickerView = .init()
    
    let nameTextField = ProductTemplatePickerTextField()
    
    let unitTextField = ChoicesPickerTextField<AnyChoiceItem>(choices: []).then {
        $0.placeholder = "Unit"
        $0.imageView.image = UIImage(named: "picker_dropdown")
        $0.isSeparatorHidden = true
    }
    
    let priceTextField = PriceTextField().then {
        $0.placeholder = "Price"
    }
    
    let descriptionTextView = TextView().then {
        $0.placeholder = "Description"
    }
   
    let quantityTextField = NumbersTextField(maxDigitsCount: 10).then {
        $0.placeholder = "Quantity"
    }
    
    let productionDateTextField = DatePickerTextField(type: .date).then {
        $0.placeholder = "Production Date"
        $0.maxDate = Date()
        $0.imageView.image = UIImage(named: "picker_dropdown")
    }
    
    let expirationDateTextField = DatePickerTextField(type: .date).then {
        $0.placeholder = "Expiration Date"
        $0.minDate = Date()
        $0.imageView.image = UIImage(named: "picker_dropdown")
    }
    
    override func setup() {
        backgroundColor = DefaultColorsProvider.backgroundPrimary
        layer.cornerRadius = 19
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        dropShadow(color: DefaultColorsProvider.decoratorShadow,
                   opacity: 0.16,
                   offSet: .init(width: 0, height: -3.5),
                   radius: 3.5)
        
        subviewsPreparedAL {
            containerStackView
        }
        
        containerStackView
            .axis(.vertical)
            .spacing(15)
            .alignment(.fill)
            .distribution(.fill)
        
        containerStackView.addingArrangedSubviews {
            titleLabel
            imagesPickerView
            nameTextField
            [productionDateTextField, expirationDateTextField].groupIntoHorizontalStackView()
            [unitTextField, priceTextField].groupIntoHorizontalStackView()
            descriptionTextView
            quantityTextField
        }
        
        imagesPickerView.height(100)
        descriptionTextView.height(200)
        
        containerStackView.fillContainer(padding: 20)
        
        titleLabel.font = .font(for: .bold, size: 21)
        titleLabel.text = "Item Description"
    }
}

extension Array where Element == UITextField {
    fileprivate func groupIntoHorizontalStackView() -> UIStackView {
        let stackView = UIStackView()
        
        stackView.axis(.horizontal)
            .spacing(15)
            .alignment(.fill)
            .distribution(.fillEqually)
        
        stackView.addingArrangedSubviews(self)
        
        return stackView
    }
    
    fileprivate func groupIntoVerticalStackView() -> UIStackView {
        let stackView = UIStackView()
        
        stackView.axis(.horizontal)
            .spacing(15)
            .alignment(.fill)
            .distribution(.fillEqually)
        
        stackView.addingArrangedSubviews(self)
        
        return stackView
    }
}

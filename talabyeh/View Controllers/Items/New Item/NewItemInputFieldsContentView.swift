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
    
    let nameTextField: BorderedTextField = .init()
    let unitTextField: ChoicesPickerTextField<AnyChoiceItem> = .init(choices: [])
    let priceTextField: PriceTextField = .init()
    let descriptionTextView: TextView = .init()
    let moreDetailsTextField: BorderedTextField = .init()
    
    let quantityStackView: UIStackView = .init()
    let quantityTextField: NumbersTextField = .init(maxDigitsCount: 10)
    let quantityUnitTextField: ChoicesPickerTextField<AnyChoiceItem> = .init(choices: [])
    
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
        
        quantityStackView
            .axis(.horizontal)
            .spacing(15)
            .alignment(.fill)
            .distribution(.fillEqually)
        
        containerStackView
            .axis(.vertical)
            .spacing(15)
            .alignment(.fill)
            .distribution(.fill)
        
        quantityStackView.addingArrangedSubviews {
            quantityTextField
            quantityUnitTextField
        }
        
        containerStackView.addingArrangedSubviews {
            titleLabel
            imagesPickerView
            nameTextField
            unitTextField
            priceTextField
            descriptionTextView
            moreDetailsTextField
            quantityStackView
        }
        
        nameTextField.placeholder = "Product Name"
        unitTextField.placeholder = "Unite"
        priceTextField.placeholder = "Price"
        descriptionTextView.placeholder = "Discretions"
        moreDetailsTextField.placeholder = "More Details"
        
        
        
        imagesPickerView.height(100)
        descriptionTextView.height(200)
        [nameTextField, unitTextField, priceTextField, quantityStackView, moreDetailsTextField].forEach {
            $0.height(50)
        }
        
        containerStackView.fillContainer(padding: 20)
        
        titleLabel.font = .font(for: .bold, size: 21)
        titleLabel.text = "Item discrptions"
        
        quantityStackView.isHidden = true
    }
}

//
//  DeliveryInformationContentView.swift
//  talabyeh
//
//  Created by Hussein Work on 08/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

class DeliveryInformationContentView: BasicViewWithSetup {

    fileprivate var fieldsStackView = UIStackView().then {
        $0.alignment(.fill)
            .distribution(.fill)
            .axis(.vertical)
            .spacing(15)
            .preparedForAutolayout()
    }
    
    
    let deliveryFeeTextField = NumbersTextField(maxDigitsCount: 10, allowsDicimals: true).then {
        $0.placeholder = "Delivery Charge"
    }
    
    let deliveryAreaInputView = DeliveryAreaInputView()
    
    let deliveryOptionView = CheckboxLabelView(title: "Available for Delivery", icon: nil)
    let pickupOptionView = CheckboxLabelView(title: "Available for Picup", icon: nil)
    let freeDeliveryOptionView = CheckboxLabelView(title: "Free Delivery", icon: nil)

    
    override func setup() {
        backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        view.subviewsPreparedAL {
            fieldsStackView
        }
        
        fieldsStackView.fillContainer()
        fieldsStackView.addingArrangedSubviews {
            deliveryAreaInputView
            deliveryOptionView
            pickupOptionView
            deliveryFeeTextField
            freeDeliveryOptionView
        }
    }
}

class DeliveryAreaInputView: BasicViewWithSetup {
    
    var isChecked: Bool = false {
        didSet {
            backgroundColor = isChecked ? DefaultColorsProvider.tintSecondary : DefaultColorsProvider.containerBackground1
        }
    }
    
    let titleLabel = UILabel().then {
        $0.font = .font(for: .bold, size: 21)
        $0.textColor = DefaultColorsProvider.tintPrimary
        $0.text = "Delivery Area"
    }
    
    let arrowImageView = UIImageView().then {
        $0.image = UIImage(named: "right-arrow")
        $0.tintColor = DefaultColorsProvider.tintPrimary
        $0.contentMode = .scaleAspectFit
    }

    override func setup() {
        subviewsPreparedAL {
            titleLabel
            arrowImageView
        }
        
        titleLabel.top(12).bottom(12).leading(20)
        arrowImageView.trailing(20).height(15).width(15).centerVertically()
        titleLabel.Trailing == arrowImageView.Leading - 15
        
        isChecked = true
        layer.cornerRadius = 10
    }
}

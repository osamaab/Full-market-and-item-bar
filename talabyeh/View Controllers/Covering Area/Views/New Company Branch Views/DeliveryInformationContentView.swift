//
//  DeliveryInformationContentView.swift
//  talabyeh
//
//  Created by Hussein Work on 08/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

class DeliveryInformationContentView: BasicViewWithSetup, InputCardViewType {
    
    struct Output {
        let cities: [CityItem]
        let availableForDelivery: Bool
        let availableForPickup: Bool
        let freeDelivery: Bool
        let deliveryFee: String?
    }

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
    
    var cities: [CityItem] = []
    
    let deliveryAreaInputView = DeliveryAreaInputView()
    
    let deliveryOptionView = CheckboxLabelView(title: "Available for Delivery", icon: nil)
    let pickupOptionView = CheckboxLabelView(title: "Available for Pickup", icon: nil)
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
        
        deliveryAreaInputView.add(gesture: .tap(1)){ [unowned self] in
            let cityPicker = CityPickerViewController()
            cityPicker.delegate = self
            cityPicker.selectedOptions = Set(cities)
            cityPicker.selectionMode = .multiple
            
            UIApplication.topViewController()?.present(cityPicker, animated: true, completion: nil)
        }
        
        deliveryOptionView.add(gesture: .tap(1)){
            self.deliveryOptionView.isChecked = !self.deliveryOptionView.isChecked
            self.updateStatusViews()
        }
        
        pickupOptionView.add(gesture: .tap(1)){
            self.pickupOptionView.isChecked = !self.pickupOptionView.isChecked
        }
        
        freeDeliveryOptionView.add(gesture: .tap(1)){
            self.freeDeliveryOptionView.isChecked = !self.freeDeliveryOptionView.isChecked
            self.updateStatusViews()
        }
        
        self.updateStatusViews()
    }
    
    func updateStatusViews(){
        self.freeDeliveryOptionView.isHidden = !self.deliveryOptionView.isChecked
        self.deliveryFeeTextField.isHidden = !self.deliveryOptionView.isChecked || self.freeDeliveryOptionView.isChecked
    }
    
    func validateAndReturnData() throws -> Output {
        guard cities.count > 0 else {
            throw InputCardViewValidationError.missingFields
        }
        
        let isFree = freeDeliveryOptionView.isChecked
        let isPickup = pickupOptionView.isChecked
        let isDelivery = deliveryOptionView.isChecked
        
        let fee = deliveryFeeTextField.text
        if !isFree && isDelivery {
            guard let fee = fee, !fee.isEmpty else {
                throw InputCardViewValidationError.missingFields
            }
        }
        
        return Output(cities: cities, availableForDelivery: isDelivery, availableForPickup: isPickup, freeDelivery: isFree, deliveryFee: fee)
    }
}

extension DeliveryInformationContentView: CityPickerViewControllerDelegate {
    func cityPickerViewController(_ sender: CityPickerViewController, didFinishWith options: [CityItem]) {
        self.cities = options
        sender.dismiss(animated: true, completion: nil)
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

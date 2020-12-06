//
//  CheckoutViewController+Cards.swift
//  talabyeh
//
//  Created by Hussein Work on 02/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia


class CHCartSummaryCardView: BasicViewWithSetup {
    
    let subtotalView: FieldView<UILabel> = .init(title: "Subtotal")
    let promotionDiscountsView: FieldView<UILabel> = .init(title: "Promotion Discounts")
    let addCouponView: FieldView<BorderedTextField> = .init(title: "Add Copoun")
    let separatorView: UIView = .init()
    let deliveryChargesView: FieldView<UILabel> = .init(title: "Delivery Charges")
    let totalView: FieldView<UILabel> = .init(title: "Est. Total")
    
    let containerStackView: UIStackView = .init()
    
    override func setup() {
        addSubview(containerStackView)
        
        containerStackView.alignment(.fill)
            .distribution(.fill)
            .axis(.vertical)
            .spacing(15)
            .preparedForAutolayout()
        containerStackView.fillContainer()

        
        containerStackView.addingArrangedSubviews {
            subtotalView
            promotionDiscountsView
            separatorView
            addCouponView
            deliveryChargesView
            totalView
        }
        
        separatorView.backgroundColor = DefaultColorsProvider.itemBackground
        separatorView.height(1)
        
        addCouponView.contentView.height(35).width(100)
        
        moreSetup()
    }
    
    fileprivate func moreSetup(){
        let fieldsWithLabelContent: [FieldView<UILabel>] = [
            subtotalView,
            promotionDiscountsView,
            deliveryChargesView,
            totalView
        ]
        
        fieldsWithLabelContent.forEach {
            $0.contentView.font = .font(for: .bold, size: 13)
        }
        
        subtotalView.contentView.text = "JD 360"
        promotionDiscountsView.contentView.text = "JD 3.000"
        deliveryChargesView.contentView.text = "Rs. 0.00"
        totalView.contentView.text = "JD 320"
        
        totalView.titleLabel.font = .font(for: .bold, size: 18)
        totalView.titleLabel.textColor = DefaultColorsProvider.darkerTint
        
        totalView.contentView.font = .font(for: .bold, size: 18)
        totalView.contentView.textColor = DefaultColorsProvider.darkerTint

    }
}


class CHRecipientDetailsCardView: BasicViewWithSetup {
    
    let nameTextField: BorderedTextField = .init()
    let phoneCodeTextField: BorderedTextField = .init()
    let phoneTextField: BorderedTextField = .init()
    
    override func setup() {
        subviews {
            nameTextField
            phoneCodeTextField
            phoneTextField
        }
        
        [nameTextField, phoneCodeTextField, phoneTextField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.height(40)
        }
        
        nameTextField.top(0).leading(0).centerHorizontally()
        phoneCodeTextField.bottom(0).width(25%)
        
        phoneCodeTextField.Leading == nameTextField.Leading
        phoneCodeTextField.Trailing == phoneTextField.Leading - 15
        phoneCodeTextField.Top == nameTextField.Bottom + 15
        
        phoneTextField.Trailing == nameTextField.Trailing
        phoneTextField.CenterY == phoneCodeTextField.CenterY
        phoneTextField.Bottom == phoneCodeTextField.Bottom
    }
}

class CHDeliveryInformationCardView: BasicViewWithSetup {
    
    var fieldViews: [CHDeliveryInformationFieldView] = []
    let containerStackView: UIStackView = .init()
    
    override func setup() {
        addSubview(containerStackView)
        
        containerStackView.alignment(.fill)
            .distribution(.fillEqually)
            .axis(.vertical)
            .spacing(15)
            .preparedForAutolayout()
        containerStackView.fillContainer()
        
        let options = ["Store Delivery", "Storage", "Pickup"].map {
            CHDeliveryInformationFieldView(title: $0)
        }
        
        fieldViews.append(contentsOf: options)
        options.forEach { view in
            containerStackView.addArrangedSubview(view)
            
            view.onTap = { [unowned self] in
                view.setSelected(true, animated: false)
                
                fieldViews.forEach { itemView in
                    if itemView != view {
                        itemView.setSelected(false, animated: true)
                    }
                }
            }
        }
    }
}

class CHDeliveryInformationFieldView: BasicViewWithSetup {
    let button: UIButton = .init()
    let textField: LocationPickerTextField = .init()
    
    var onTap: (() -> Void)?
    
    fileprivate(set) var isSelected: Bool = false
    
    init(title: String){
        super.init(frame: .zero)
        button.setTitle(title, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup() {
        button.layer.borderWidth = 1
        button.layer.borderColor = DefaultColorsProvider.fieldBorder.cgColor
        button.setTitleColor(DefaultColorsProvider.text, for: .normal)
        
        subviews {
            button
            textField
        }
        
        button.top(0).leading(0).bottom(0).width(45%)
        textField.top(0).trailing(0).bottom(0).width(45%)
        button.height(45)
        
        button.add(event: .touchUpInside) {
            self.onTap?()
        }
        
        setSelected(false, animated: false)
    }
    
    func setSelected(_ isSelected: Bool, animated: Bool){
        self.isSelected = isSelected
        
        let block = {
            self.button.backgroundColor = isSelected ? DefaultColorsProvider.darkerTint.withAlphaComponent(0.2) : DefaultColorsProvider.background
            self.button.setTitleColor(isSelected ? DefaultColorsProvider.darkerTint : DefaultColorsProvider.text, for: .normal)
            self.button.titleLabel?.font = isSelected ? .font(for: .bold, size: 17) : .font(for: .medium, size: 17)
        }
        
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.allowUserInteraction, .beginFromCurrentState], animations: block, completion: nil)
        } else {
            block()
        }
    }
}

class CHDeliveryDateCardView: BasicViewWithSetup {
    
    let containerStackView: UIStackView = .init()
    
    let titleLabel: UILabel = .init()
    
    let datesTextField: WeekdaysRangePickerTextField = .init()
    let timesTextField: TimeRangePickerTextField = .init()
    
    override func setup() {
        addSubview(containerStackView)
        
        containerStackView.alignment(.fill)
            .distribution(.fill)
            .axis(.vertical)
            .spacing(15)
            .preparedForAutolayout()
        containerStackView.fillContainer()
        
        titleLabel.font = .font(for: .medium, size: 14)
        titleLabel.numberOfLines = 0
        titleLabel.text = "Your delivery date should be within 7 days starting from today"
        titleLabel.textColor = DefaultColorsProvider.darkerTint.withAlphaComponent(0.4)
        
        containerStackView.addingArrangedSubviews {
            titleLabel
            datesTextField
            timesTextField
        }
        
        datesTextField.height(45)
        timesTextField.height(45)
    }
}

class CHDeliveryInstructionsCardView: BasicViewWithSetup {
    
    let textView = UITextView()
    let checkboxLabel = UILabel()
    let checkboxView = UIImageView()
    let footerLabel = UILabel()
    
    override func setup() {
        subviews {
            checkboxView
            checkboxLabel
            textView
            footerLabel
        }
        
        
    }
}

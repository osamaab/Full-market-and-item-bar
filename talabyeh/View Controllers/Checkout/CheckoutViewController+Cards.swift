//
//  CheckoutViewController+Cards.swift
//  talabyeh
//
//  Created by Hussein Work on 02/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia


//MARK: Cart Summary
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
        
        separatorView.backgroundColor = DefaultColorsProvider.containerBackground3
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
        totalView.titleLabel.textColor = DefaultColorsProvider.tintPrimary
        
        totalView.contentView.font = .font(for: .bold, size: 18)
        totalView.contentView.textColor = DefaultColorsProvider.tintPrimary

    }
}


//MARK:Recipient Details
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

//MARK: Delivery Information
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
        button.layer.borderColor = DefaultColorsProvider.decoratorBorder.cgColor
        button.setTitleColor(DefaultColorsProvider.textPrimary1, for: .normal)
        
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
            self.button.backgroundColor = isSelected ? DefaultColorsProvider.tintPrimary.withAlphaComponent(0.2) : DefaultColorsProvider.backgroundPrimary
            self.button.setTitleColor(isSelected ? DefaultColorsProvider.tintPrimary : DefaultColorsProvider.textPrimary1, for: .normal)
            self.button.titleLabel?.font = isSelected ? .font(for: .bold, size: 17) : .font(for: .medium, size: 17)
        }
        
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.allowUserInteraction, .beginFromCurrentState], animations: block, completion: nil)
        } else {
            block()
        }
    }
}

//MARK: Delivery Date
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
        titleLabel.textColor = DefaultColorsProvider.tintPrimary.withAlphaComponent(0.4)
        
        containerStackView.addingArrangedSubviews {
            titleLabel
            datesTextField
            timesTextField
        }
        
        datesTextField.height(45)
        timesTextField.height(45)
    }
}

//MARK: Delivery Instructions
class CHDeliveryInstructionsCardView: BasicViewWithSetup {
    
    let textView = UITextView()
    let checkboxLabel = UILabel()
    let checkboxView = CheckboxView()
    let footerLabel = UILabel()
    
    override func setup() {
        subviewsPreparedAL {
            checkboxView
            checkboxLabel
            textView
            footerLabel
        }
        
        textView.font = .font(for: .medium, size: 17)
        textView.contentInset = .init(top: 15, left: 20, bottom: 15, right: 20)
        textView.layer.cornerRadius = 8
        textView.layer.borderWidth = 1
        textView.layer.borderColor = DefaultColorsProvider.decoratorBorder.cgColor
                
        checkboxLabel.font = .font(for: .semiBold, size: 14)
        checkboxLabel.textColor = DefaultColorsProvider.textSecondary1
        checkboxLabel.text = "Call receiver before delivery"
        
        footerLabel.font = .font(for: .semiBold, size: 12)
        footerLabel.textColor = DefaultColorsProvider.textSecondary1
        footerLabel.text = "0 of 100 words"
        
        // layout
        checkboxView.height(25).width(25).top(0).leading(0)
        checkboxLabel.trailing(0)
        
        alignVertically(checkboxView, with: checkboxLabel)
        checkboxLabel.Leading == checkboxView.Trailing + 15
        
        textView.height(150).leading(0).trailing(0)
        textView.Top == checkboxView.Bottom + 15
        
        footerLabel.bottom(0).leading(0).trailing(0)
        footerLabel.Top == textView.Bottom + 15
    }
}


// looks challenging :)))))))
//MARK: Payment Method
class CHPaymentMethodCardView: BasicViewWithSetup {
    
    struct PaymentMethodType: Hashable {
        let id: String = UUID().uuidString
        let image: UIImage?
        let title: String
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }
    
    class ItemView: BasicViewWithSetup {
        let imageView = UIImageView()
        let titleLabel = UILabel()
        let checkboxView = CheckboxView()
        
        override func setup() {
            subviewsPreparedAL {
                imageView
                titleLabel
                checkboxView
            }
            
            imageView.layer.cornerRadius = 2
            imageView.layer.borderWidth = 0.5
            imageView.layer.borderColor = DefaultColorsProvider.decoratorBorder.cgColor
            imageView.contentMode = .scaleAspectFit
            
            titleLabel.font = .font(for: .medium, size: 16)
            titleLabel.textColor = DefaultColorsProvider.textPrimary1
            
            checkboxView.isSelected = false
            
            imageView.leading(0).top(0).bottom(0).width(75)
            titleLabel.centerVertically()
            checkboxView.trailing(0).centerVertically().height(20).width(20)
            
            titleLabel.Leading == imageView.Trailing + 15
            titleLabel.Trailing == checkboxView.Leading - 15
        }
    }
    
    fileprivate var stackView: UIStackView = .init()
    fileprivate var itemViews: [ItemView] = []
    fileprivate var dateTextField: DatePickerTextField = .init()
    fileprivate var placeholderItemView: ItemView = .init()
    
    fileprivate(set) var paymentMethods: [PaymentMethodType]
    
    init(paymentMethods: [PaymentMethodType]){
        self.paymentMethods = paymentMethods
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup() {
        subviewsPreparedAL {
            stackView
        }
        
        stackView.alignment(.fill)
            .axis(.vertical)
            .distribution(.fill)
            .spacing(15)
        
        
        dateTextField.height(45)
        stackView.fillContainer()
        
        placeholderItemView.checkboxView.isHidden = true
        placeholderItemView.titleLabel.text = "Add Card"
        placeholderItemView.height(55)
        
        stackView.insertArrangedSubview(placeholderItemView, at: 0)
        
        paymentMethods.forEach {
            add(paymentMethod: $0)
        }
    }
    
    func add(paymentMethod: PaymentMethodType){
        insertItemView(for: paymentMethod)
    }
    
    fileprivate func insertItemView(for item: PaymentMethodType){
        let view = ItemView()
        view.titleLabel.text = item.title
        view.imageView.image = item.image
        view.checkboxView.isSelected = true
        view.height(55)
        view.restorationIdentifier = item.id
        
        itemViews.append(view)
        stackView.insertArrangedSubview(view, at: itemViews.count - 1)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self.stackView) else {
            return
        }
        
        guard let itemView = (itemViews.first {
            $0.frame.contains(location)
        }) else {
            return
        }
        
        if itemView == placeholderItemView {
            // placeholder selected, ignoring
            return
        }
        
        stackView.removeArrangedSubview(dateTextField)
        dateTextField.removeFromSuperview()
        
        itemViews.forEach { $0.checkboxView.isSelected = false }
        itemView.checkboxView.isSelected = !itemView.checkboxView.isSelected
        
        let indexOfSelected = stackView.arrangedSubviews.firstIndex(of: itemView)!
        stackView.insertArrangedSubview(dateTextField, at: indexOfSelected + 1)
    }
}

//MARK: Label
class CHLabelCardView: BasicViewWithSetup {
    
    let titleLabel: UILabel = .init()
    
    init(title: String){
        super.init(frame: .zero)
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup() {
        subviewsPreparedAL {
            titleLabel
        }
        
        titleLabel.font = .font(for: .bold, size: 18)
        titleLabel.numberOfLines = 0
        
        titleLabel.fillContainer()
    }
}

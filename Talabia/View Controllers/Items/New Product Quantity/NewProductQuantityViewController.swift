//
//  NewProductQuantityViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 08/03/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import SwiftEntryKit

protocol NewProductQuantityViewControllerDelegate: class {
    func newProductQuantityViewController(_ sender: NewProductQuantityViewController, didFinishWith form: NewProductQuantityViewController.NewQuantityForm)
}

class NewProductQuantityViewController: UIViewController {

    struct NewQuantityForm {
        let productionDate: Date
        let expirationDate: Date
        let quantity: Int
    }
    
    let product: Product

    weak var delegate: NewProductQuantityViewControllerDelegate?
    
    let contentView: NewProductQuantityContentView = .init()
    
    init(product: Product, delegate: NewProductQuantityViewControllerDelegate?) {
        self.product = product
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.view.backgroundColor = DefaultColorsProvider.backgroundSecondary
        
        self.view.subviewsPreparedAL {
            contentView
        }
        
        contentView.fillContainer()
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        
        contentView.closeButton.add(event: .touchUpInside) { [unowned self] in
            self.dismiss()
        }
        
        contentView.saveButton.add(event: .touchUpInside) { [unowned self] in
            guard let quantity = Int(self.contentView.quantityTextField.text ?? "") else {
                return
            }
            
            let productionDate = self.contentView.productionDateField.currentDate
            let expirationDate = self.contentView.expirationDateField.currentDate

            self.delegate?.newProductQuantityViewController(self, didFinishWith: .init(productionDate: productionDate, expirationDate: expirationDate, quantity: quantity))
        }
    }
    
    func present(){
        SwiftEntryKit.display(entry: self, using: attributesForDisplaying())
    }
    
    func dismiss(){
        SwiftEntryKit.dismiss(.all)
    }
    
    func attributesForDisplaying() -> EKAttributes {
        var alertAttributes = EKAttributes()
        alertAttributes.position = .center
        alertAttributes.windowLevel = .statusBar
        alertAttributes.screenBackground = .color(color: EKColor(UIColor.black.withAlphaComponent(0.2)))
        alertAttributes.roundCorners = .all(radius: 20)
        alertAttributes.shadow = .active(with: .init(color: .init(UIColor.lightGray), opacity: 0.2, radius: 4, offset: .zero))
        
        alertAttributes.screenInteraction = .dismiss
        
        alertAttributes.displayDuration = .infinity
        alertAttributes.entryInteraction = .forward
        alertAttributes.name = String(describing: self)
        alertAttributes.hapticFeedbackType = .none
        alertAttributes.entranceAnimation = .init(translate: nil, scale: nil, fade: .init(from: 0, to: 1, duration: 0.25))
        alertAttributes.exitAnimation = .init(translate: nil, scale: nil, fade: .init(from: 0, to: 1, duration: 0.25))
        
        
        let heightSize: EKAttributes.PositionConstraints.Edge = .intrinsic
        alertAttributes.positionConstraints.size = .init(width: .ratio(value: 0.8), height: heightSize)
                
        return alertAttributes
    }
}


class NewProductQuantityContentView: BasicViewWithSetup {
    
    let containerStackView = UIStackView().then {
        $0.alignment(.fill)
            .axis(.vertical)
            .distribution(.fill)
            .spacing(15)
            .preparedForAutolayout()
    }
    
    let titleLabel = UILabel().then {
        $0.font = .font(for: .bold, size: 21)
        $0.textColor = DefaultColorsProvider.textPrimary1
        $0.text = "Adding new quantity"
    }
    
    let closeButton = UIButton().then {
        $0.tintColor = DefaultColorsProvider.textPrimary1
        $0.setImage(.named("close"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let productionDateField = DatePickerTextField(type: .date).then {
        $0.placeholder = "Production Date"
    }
    
    let expirationDateField = DatePickerTextField(type: .date).then {
        $0.placeholder = "Exp. Date"
    }
    
    let quantityTextField = NumbersTextField(maxDigitsCount: 10, allowsDicimals: false).then {
        $0.placeholder = "Quantity"
    }
    
    let saveButton = RoundedButton().then {
        $0.backgroundColor = DefaultColorsProvider.tintPrimary
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .font(for: .medium, size: 15)
        $0.setTitle("SAVE", for: .normal)
        $0.contentEdgeInsets = .init(top: 12, left: 20, bottom: 12, right: 20)
    }
    
    override func setup() {
        let stackView = UIStackView()
        stackView.alignment(.fill)
            .axis(.vertical)
            .distribution(.fillEqually)
            .spacing(5)
            .preparedForAutolayout()

        stackView.addingArrangedSubviews {
            productionDateField
            expirationDateField
        }
        
        layer.cornerRadius = 20
        backgroundColor = DefaultColorsProvider.backgroundSecondary
        
        subviewsPreparedAL {
            containerStackView
            closeButton
        }
        
        
        containerStackView.addingArrangedSubviews {
            titleLabel
            productionDateField
            expirationDateField

//            stackView
            quantityTextField
            saveButton
        }
        
        closeButton.trailing(15).top(15)
        containerStackView.left(20).right(20).top(20).bottom(20)
        
        clipsToBounds = true
    }
}

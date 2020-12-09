//
//  NewPaymentCreditCardContentView.swift
//  talabyeh
//
//  Created by Hussein Work on 09/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class NewPaymentCreditCardContentView: BasicViewWithSetup {

    /**
     Internally, we reuse the distributer money content view, cause it matches the ui, and wrap it into a card :))))
     */
    let contentView: NDMoneyDistributionContentView
    
    /**
     The content view is held into a card
     */
    let cardContainerView: CardContainerView

    
    /**
     Altough we need a button with the content view :)
     */
    let cardContentView: UIView
    
    
    /**
     The submit button
     */
    let submitButton: UIButton
    
    
    
    init(){
        self.contentView = .init()
        self.cardContentView = .init()
        self.submitButton = .init()
        self.cardContainerView = .init(title: nil, contentView: cardContentView)
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup() {
        addSubview(cardContainerView)
        cardContainerView.translatesAutoresizingMaskIntoConstraints = false
        cardContainerView.fillContainer()
        
        cardContentView.subviewsPreparedAL {
            contentView
            submitButton
        }
        
        cardContainerView.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                
        contentView.top(0).leading(0).trailing(0)
        submitButton.trailing(0).bottom(0).width(44).height(44)
        submitButton.Top == contentView.Bottom + 15
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldTextDidChange), name: UITextField.textDidChangeNotification, object: nil)

        setButtonState(isSelected: canSubmit())
    }
    
    @objc func textFieldTextDidChange(){
        setButtonState(isSelected: canSubmit())
    }
    
    func canSubmit() -> Bool {
        let nameValidated = !(contentView.nameTextField.text?.isEmpty ?? true)
        let numberValidated = !contentView.numberTextField.hasErrors
        let cvvValidated = !(contentView.cvvTextField.text?.isEmpty ?? true)
        
        return nameValidated && numberValidated && cvvValidated
    }
    
    func setButtonState(isSelected: Bool){
        submitButton.setImage(isSelected ? UIImage(named: "card-submit-selected") : UIImage(named: "card-submit"), for: .normal)
    }
}

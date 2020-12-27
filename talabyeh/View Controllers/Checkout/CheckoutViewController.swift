//
//  CheckoutViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 02/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class CheckoutViewController: UIViewController {
    
    let contentView: CheckoutContentView = .init()
    
    let cartSummaryView = CHCartSummaryCardView()
    let recipientDetailsCardView = CHRecipientDetailsCardView()
    let deliveryInformationCardView = CHDeliveryInformationCardView()
    let deliveryDateCardView = CHDeliveryDateCardView()
    let deliveryInstructions = CHDeliveryInstructionsCardView()
    let paymentMethodView = CHPaymentMethodCardView(paymentMethods: [])
    let distributerOptionView = CHLabelCardView(title: "If you want specific distributor Please choose..")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = DefaultColorsProvider.backgroundSecondary
        hidesBottomBarWhenPushed = true
        
        setupViews()
        setupCardViews()
    }
    
    fileprivate func setupViews(){
        self.view.backgroundColor = DefaultColorsProvider.backgroundSecondary
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.scrollContainerView.scrollView.contentInset.bottom += 100
        
        view.subviews {
            contentView
        }
        
        contentView.left(0).right(0)
        contentView.Top == view.safeAreaLayoutGuide.Top
        contentView.Bottom == view.safeAreaLayoutGuide.Bottom
    }
    
    fileprivate func setupCardViews(){
        /**
         Cards to add:
         - Cart Summary
         - Recipitent Details
         - Delivery Information
         - Delivery Date
         - Delivery Instructions
         - Payment Method
         */
        
        
        contentView.insertCardView(with: cartSummaryView, title: "Cart Summary")
        contentView.insertCardView(with: recipientDetailsCardView, title: "Recipient Details")
        contentView.insertCardView(with: deliveryInformationCardView, title: "Delivery Information")
        contentView.insertCardView(with: deliveryDateCardView, title: "Delivery Date")
        contentView.insertCardView(with: deliveryInstructions, title: "Delivery Instructions")
        contentView.insertCardView(with: paymentMethodView, title: "Payment Method")
        contentView.insertCardView(with: distributerOptionView, title: nil)
    }
}

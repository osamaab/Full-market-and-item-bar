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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = DefaultColorsProvider.background1
        hidesBottomBarWhenPushed = true
        
        setupViews()
        setupCardViews()
    }
    
    fileprivate func setupViews(){
        self.view.backgroundColor = DefaultColorsProvider.background1
        
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
    }
}

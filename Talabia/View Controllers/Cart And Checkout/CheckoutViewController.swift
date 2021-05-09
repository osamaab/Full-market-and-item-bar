//
//  CheckoutViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 02/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia
import XCoordinator



/**
 At the checkout, we want to retrive the store locations of the current user, in addition to the fire action that the user can make to select the company branch ( when using the checkout )
 
 We need:
 - User's store locations
 - Cart Contents
 - Delivery Store Location ( actully, this can't be changed )
 
 */
class CheckoutViewController: UIViewController {

    
    //MARK: Views
    let contentView: CheckoutContentView = .init()
    
    let deliveryInfoView = CHDeliveryLocationCardView()
    let cartSummaryView = CHCartSummaryCardView()
    let recipientDetailsCardView = CHRecipientDetailsCardView()
    let deliveryInformationCardView = CHDeliveryInformationCardView()
    let deliveryDateCardView = CHDeliveryDateCardView()
    let deliveryInstructions = CHDeliveryInstructionsCardView()
    let paymentMethodView = CHPaymentMethodCardView(paymentMethods: [])
    let distributerOptionView = CHPreferredDistributorView(title: "If you want specific distributor Please choose..")
    
    let nextView: BottomNextButtonView = .init(title: "Checkout")
    
    
    //MARK: Dependencies
    
    let router: UnownedRouter<CartRoute>
    let cart: CartContents
    
    internal init(router: UnownedRouter<CartRoute>, cart: CartContents) {
        self.router = router
        self.cart = cart
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

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
        contentView.scrollContainerView.scrollView.contentInset.top += 20
        
        view.subviews {
            contentView
            nextView
        }
        
        contentView.left(0).right(0)
        contentView.Top == view.safeAreaLayoutGuide.Top
        contentView.Bottom == view.safeAreaLayoutGuide.Bottom
        
        nextView.bottom(0).leading(0).trailing(0)
        navigationItem.title = "Checkout"
    }
    
    fileprivate func setupCardViews(){
        contentView.insertCardView(with: deliveryInfoView, title: nil)
        contentView.insertCardView(with: cartSummaryView, title: "Cart Summary")
        contentView.insertCardView(with: recipientDetailsCardView, title: "Recipient Details")
        contentView.insertCardView(with: deliveryDateCardView, title: "Delivery Date")
        contentView.insertCardView(with: deliveryInstructions, title: "Delivery Instructions")
        contentView.insertCardView(with: paymentMethodView, title: "Payment Method")
        let distributorOptionCard = contentView.insertCardView(with: distributerOptionView, title: nil)
        distributorOptionCard.backgroundColor = DefaultColorsProvider.tintSecondary
        
        distributerOptionView.add(gesture: .tap(1)) { [unowned self] in
            self.router.trigger(.selectPreferredDistributor)
        }
    }
}

//
//  NewCompanyBranchViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 08/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

class NewCompanyBranchViewController: UIViewController {
    
    let contentView: NewCompanyBranchContentView = .init()
    let bottomView: BottomNextButtonView = .init(title: "Save")

    
    let locationInfoCard = BasicLocationInformationContentView()
    let workingDaysInfoCard = TimeInformationContentView()
    let contactInfoCard = ContactInformationContentView()
    let deliveryInfoCard = DeliveryInformationContentView()
    let branchStatusCard = BranchStatusContentView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            bottomView
        }
        
        contentView.left(0).right(0)
        contentView.Top == view.safeAreaLayoutGuide.Top
        contentView.Bottom == view.safeAreaLayoutGuide.Bottom
        
        bottomView.right(0).left(0).bottom(0)
    }
    
    fileprivate func setupCardViews(){
        // insert card views here..
        contentView.insertCardView(with: locationInfoCard, title: "Company Location ( Offices, Manufa.. )")
        contentView.insertCardView(with: workingDaysInfoCard, title: "Working time")
        contentView.insertCardView(with: contactInfoCard, title: "Contact Details")
        contentView.insertCardView(with: deliveryInfoCard, title: "Delivery Information")
        contentView.insertCardView(with: branchStatusCard, title: "Status")
    }
}

//
//  CompanyMoreInfoContentView.swift
//  Talabia
//
//  Created by Osama Abu hdba on 17/05/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import Stevia
import UIKit

//MARK:- Certificates Card

class CertificatesCardView: BasicViewWithSetup {
    
    let containerStackView: UIStackView = .init()
    let verticalStackView: UIStackView = .init()
    
    let titleLabel: UILabel = .init()
    let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "menu_profile")
        $0.tintColor = DefaultColorsProvider.tintPrimary
    }
    let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "cirteficate")
    }
    override func setup() {
        addSubview(verticalStackView)
        
        containerStackView.alignment(.leading)
            .distribution(.fill)
            .axis(.horizontal)
            .spacing(15)
            .preparedForAutolayout()
        containerStackView.fillContainer()
        verticalStackView.alignment(.leading)
            .distribution(.fill)
            .axis(.vertical)
            .spacing(15)
            .preparedForAutolayout()
        verticalStackView.fillContainer()
        
        titleLabel.font = .font(for: .bold, size: 17)
        titleLabel.numberOfLines = 1
        titleLabel.text = "Company Profile"
        titleLabel.textColor = DefaultColorsProvider.tintPrimary
        
        
        containerStackView.addingArrangedSubviews {
            iconImageView
            titleLabel
        }
        
        verticalStackView.addingArrangedSubviews{
            containerStackView
            imageView
        }

    
    }
}

// MARK:- Company Profile Card

class CompanyProfileCardView: BasicViewWithSetup {
    
    let containerStackView: UIStackView = .init()
    let verticalStackView: UIStackView = .init()
    
    let titleLabel: UILabel = .init()
    let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "menu_profile")
    }
    let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "cirteficate")
    }
    override func setup() {
        addSubview(verticalStackView)
        
        containerStackView.alignment(.leading)
            .distribution(.fill)
            .axis(.horizontal)
            .spacing(15)
            .preparedForAutolayout()
        containerStackView.fillContainer()
        verticalStackView.alignment(.leading)
            .distribution(.fill)
            .axis(.vertical)
            .spacing(15)
            .preparedForAutolayout()
        verticalStackView.fillContainer()
        
        titleLabel.font = .font(for: .bold, size: 17)
        titleLabel.numberOfLines = 1
        titleLabel.text = "Certificates"
        titleLabel.textColor = DefaultColorsProvider.tintPrimary
        
        
        containerStackView.addingArrangedSubviews {
//            iconImageView
            titleLabel
        }
        
        verticalStackView.addingArrangedSubviews{
            containerStackView
            imageView
        }
    }
}

// MARK:- Company Review Card

class CompanyReview: BasicViewWithSetup {
    let titleLabel: UILabel = .init()
    var ratingView: RatingView = .init()
    let containerStackView: UIStackView = .init()
    let horizontalStackView: UIStackView = .init()
    let seeMoreImage = UIImageView().then{
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "right-arrow")
    }
    
    override func setup() {
        addSubview(horizontalStackView)
       
        containerStackView.alignment(.leading)
            .distribution(.fill)
            .axis(.vertical)
            .spacing(15)
            .preparedForAutolayout()
        containerStackView.fillContainer()
        
        horizontalStackView.alignment(.center)
            .distribution(.fill)
            .axis(.horizontal)
            .spacing(15)
            .preparedForAutolayout()
        horizontalStackView.fillContainer()
        
        titleLabel.font = .font(for: .bold, size: 17)
        titleLabel.numberOfLines = 1
        titleLabel.text = "Company Review"
        titleLabel.textColor = DefaultColorsProvider.tintPrimary
        
        containerStackView.addingArrangedSubviews{
            titleLabel
            ratingView
        }
        horizontalStackView.addingArrangedSubviews{
            containerStackView
            seeMoreImage
        }
        seeMoreImage.height(12).width(20)

    }
}

// MARK:- Delivered to Card

class DeliveredCardView: BasicViewWithSetup {
    
    let titleLabel1: UILabel = .init()
    let titleLabel2: UILabel = .init()
    let titleLabel3: UILabel = .init()
    let containerStackView: UIStackView = .init()
    

    override func setup() {
        addSubview(containerStackView)
        
        containerStackView.alignment(.leading)
            .distribution(.fill)
            .axis(.vertical)
            .spacing(0)
            .preparedForAutolayout()
        containerStackView.fillContainer()
        
        titleLabel1.font = .font(for: .bold, size: 17)
        titleLabel1.numberOfLines = 1
        titleLabel1.text = "Delivered to:"
        titleLabel1.textColor = DefaultColorsProvider.tintPrimary
        
        
        titleLabel2.font = .font(for: .bold, size: 17)
        titleLabel2.numberOfLines = 1
        titleLabel2.text = "Amman - Free Delivery"
        titleLabel2.textColor = DefaultColorsProvider.tintPrimary
        
        titleLabel3.font = .font(for: .bold, size: 17)
        titleLabel3.numberOfLines = 1
        titleLabel3.text = "Aqaba - 5.00JD"
        titleLabel3.textColor = DefaultColorsProvider.tintPrimary
        
        containerStackView.addingArrangedSubviews{
            titleLabel1
            titleLabel2
            titleLabel3
        }
        
        containerStackView.setCustomSpacing(20, after: titleLabel1)
    }
}

// MARK:- Payments Card

class PaymentMethodsCardView: BasicViewWithSetup {
    let containerStackView: UIStackView = .init()
    let titleLabel: UILabel = .init()
    let visaView : UIView = .init()
    let visaImageView = UIImageView().then{
        $0.image = UIImage(named: "Visa")
        $0.contentMode = .scaleAspectFit
    }
    let criditLabel = UILabel().then{
        $0.text = "Cridit"
        $0.textColor = DefaultColorsProvider.textPrimary1
        $0.font = .font(for: .bold, size: 17)
    }
    let cashLabel = UILabel()
    
    
    override func setup() {
        visaView.addSubview(visaView)
        addSubview(containerStackView)
       
        containerStackView.alignment(.leading)
            .distribution(.fill)
            .axis(.horizontal)
            .spacing(0)
            .preparedForAutolayout()
        containerStackView.fillContainer()
        
        containerStackView.addingArrangedSubviews{
            visaView
            criditLabel
            cashLabel
        }
    }
}

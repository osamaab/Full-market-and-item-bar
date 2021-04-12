//
//  CompanyProductDetailsContentView.swift
//  talabyeh
//
//  Created by Hussein Work on 22/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

class CompanyProductDetailsContentView: BasicViewWithSetup {
    
    // top image view
    // container view
    // history view
    
    let imageContainerView = BasicCardView().then {
        $0.layer.cornerRadius = 20
//        $0.clipsToBounds = true
    }
    
    let detailsContainerView = BasicCardView()
    
    let historyContainerView = BasicCardView().then {
        $0.layer.cornerRadius = 20
    }
    
    let detailsStackView: UIStackView = UIStackView().then {
        $0.alignment(.center)
            .spacing(15)
            .axis(.vertical)
            .distribution(.fill)
    }
    
    let historyStackView: UIStackView = UIStackView().then {
        $0.alignment(.fill)
            .spacing(8)
            .axis(.vertical)
            .distribution(.fillEqually)
    }
    
    let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    let topLabel = UILabel().then {
        $0.backgroundColor = DefaultColorsProvider.containerBackground1
        $0.textColor = DefaultColorsProvider.backgroundPrimary
        $0.layer.cornerRadius = 3
        $0.font = .font(for: .bold, size: 12)
        $0.textAlignment = .center
    }
    
    let newQuantityButton = RoundedButton().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = DefaultColorsProvider.tintPrimary.cgColor
        $0.backgroundColor = DefaultColorsProvider.tintSecondary
        $0.setTitleColor(DefaultColorsProvider.tintPrimary, for: .normal)
        $0.setTitle("Add new quantity", for: .normal)
        $0.titleLabel?.font = .font(for: .semiBold, size: 17)
        $0.contentEdgeInsets = .init(top: 6, left: 20, bottom: 6, right: 20)
    }
    
    let historyTitleLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .font(for: .bold, size: 21)
        $0.textColor = DefaultColorsProvider.textPrimary1
        $0.text = "Product History"
    }
    
    let titleLabel = UILabel().then {
        $0.font = .font(for: .semiBold, size: 17)
        $0.textColor = DefaultColorsProvider.textPrimary1
        $0.textAlignment = .center
    }
    
    let priceLabel = UILabel().then {
        $0.font = .font(for: .semiBold, size: 21)
        $0.textColor = DefaultColorsProvider.textPrimary1
        $0.textAlignment = .center
    }
    
    let ratingView = RatingView().then {
        $0.isHidden = true
    }
    
    let descriptionLabel = UILabel().then {
        $0.font = .font(for: .medium, size: 16)
        $0.textColor = DefaultColorsProvider.textSecondary2
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    
    let productionLabel = UILabel().then {
        $0.font = .font(for: .bold, size: 21)
        $0.textColor = DefaultColorsProvider.textPrimary1
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    
    let expirationLabel = UILabel().then {
        $0.font = .font(for: .bold, size: 21)
        $0.textColor = DefaultColorsProvider.textPrimary1
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    
    fileprivate(set) var historyLabels: [UILabel] = []
    
    override func setup() {
        subviewsPreparedAL {
            detailsContainerView
            historyContainerView
            imageContainerView
        }
        
        backgroundColor = DefaultColorsProvider.backgroundSecondary
        
        imageContainerView.top(20).width(70%).centerHorizontally().height(200)
        detailsContainerView.leading(20).trailing(20)
        historyContainerView.bottom(20).trailing(20).leading(20)
        
        detailsContainerView.Top == imageContainerView.Bottom - 30
        historyContainerView.Top == detailsContainerView.Bottom + 20
        
        setupContents()
    }
    
    fileprivate func setupContents(){
        imageContainerView.subviewsPreparedAL {
            imageView
            topLabel
        }
        
        imageView.fillContainer()
        topLabel.top(20).leading(20).height(20).width(40)
        
        detailsStackView.addingArrangedSubviews {
            newQuantityButton
            titleLabel
            priceLabel
            ratingView
            descriptionLabel
            productionLabel
            expirationLabel
        }
        
        detailsStackView.setCustomSpacing(3, after: titleLabel)
        
        detailsContainerView.subviewsPreparedAL {
            detailsStackView
        }
        
        detailsStackView.leading(20).centerHorizontally().bottom(20)
        detailsStackView.Top == imageContainerView.Bottom + 20
        
        historyContainerView.subviewsPreparedAL {
            historyStackView
        }
        
        historyStackView.top(20).leading(20).bottom(20).trailing(20)
        
        historyStackView.addingArrangedSubviews {
            historyTitleLabel
        }
    }
    
    func addHistoryText(_ text: String){
        let newLabel = UILabel()
        
        newLabel.font = .font(for: .bold, size: 21)
        newLabel.textAlignment = .center
        newLabel.text = text
        newLabel.textColor = DefaultColorsProvider.textSecondary3
        
        historyLabels.append(newLabel)
        historyStackView.addArrangedSubview(newLabel)
    }
}

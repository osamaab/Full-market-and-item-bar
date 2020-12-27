//
//  CartCollectionViewCell.swift
//  talabyeh
//
//  Created by Hussein Work on 26/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class CartCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
    }
    
    let imageContainerView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = DefaultColorsProvider.backgroundPrimary
        $0.dropShadow(color: DefaultColorsProvider.decoratorShadow,
                      opacity: 0.16,
                      offSet: .init(width: 0, height: 1),
                      radius: 2)
    }
    
    let titleLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .font(for: .semiBold, size: 14)
    }
    
    let subtitleLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .font(for: .medium, size: 13)
    }
    
    let quantitySelectionView = QuantitySelectionView(style: .small, title: nil).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let midItemsStackView: UIStackView = UIStackView().then {
        $0.alignment(.leading)
            .distribution(.fill)
            .axis(.vertical)
            .spacing(15)
            .preparedForAutolayout()
    }
    
    let likeButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(named: "heart"), for: .normal)
        $0.tintColor = DefaultColorsProvider.tintPrimary
    }
    
    
    let topLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = DefaultColorsProvider.containerBackground3
        $0.textColor = DefaultColorsProvider.backgroundPrimary
        $0.layer.cornerRadius = 1.7
        $0.font = .font(for: .bold, size: 9)
        $0.textAlignment = .center
    }
    
    let discountContainerView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.borderWidth = 1
        $0.layer.borderColor = DefaultColorsProvider.tintPrimary.withAlphaComponent(0.5).cgColor
    }
    
    let discountLabel: UILabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .font(for: .bold, size: 12)
        $0.textColor = DefaultColorsProvider.tintPrimary
        $0.textAlignment = .center
        $0.text = "Disc 5.32 JOD"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        imageContainerView.subviews {
            likeButton
            topLabel
            imageView
        }
        
        discountContainerView.addSubview(discountLabel)
        
        
        contentView.subviews {
            imageContainerView
            midItemsStackView
            discountContainerView
        }
        
        midItemsStackView.addingArrangedSubviews {
            titleLabel
            subtitleLabel
            quantitySelectionView
        }
        
        setupLayout()
    }
    
    func setupLayout(){
        imageContainerView.leading(20).bottom(10).centerVertically()
        imageContainerView.width(25%)
        imageView.centerInContainer().leading(10).top(20)
        
        topLabel.leading(8).top(8).height(15).width(30)
        likeButton.trailing(8).height(20).width(20).bottom(20)

        
        midItemsStackView.Leading == imageContainerView.Trailing + 15
        midItemsStackView.Bottom == imageContainerView.Bottom
        midItemsStackView.Top >= contentView.Top
        
        discountContainerView.Leading == midItemsStackView.Trailing + 15
        discountContainerView.Bottom == midItemsStackView.Bottom
        discountContainerView.trailing(20)

        discountLabel.fillHorizontally(padding: 20)
        discountLabel.fillVertically(padding: 10)
    }
}

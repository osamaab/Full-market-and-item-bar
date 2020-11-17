//
//  DistributerCollectionViewCell.swift
//  talabyeh
//
//  Created by Hussein Work on 17/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class DistributerCollectionViewCell: UICollectionViewCell {
    
    let titleLabel: UILabel = .init()
    let subtitleLabel: UILabel = .init()
    let imageView: UIImageView = .init()
    let arrowImageView: UIImageView = .init()
    
    let locationContainerView: UIView = .init()
    let locationImageView: UIImageView = .init()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        backgroundColor = .white
        contentView.backgroundColor = .white
        
        layer.cornerRadius = 5.4
        
        dropShadow(color: .black, opacity: 0.05, offSet: .init(width: 0, height: 3.4), radius: 3.4, scale: true)
        
        titleLabel.font = .font(for: .semiBold, size: 16)
        titleLabel.textColor = DefaultColorsProvider.darkerTint
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        subtitleLabel.font = .font(for: .regular, size: 13)
        subtitleLabel.textColor = DefaultColorsProvider.secondaryText
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.backgroundColor = DefaultColorsProvider.itemBackground
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 25
        
        locationContainerView.backgroundColor = DefaultColorsProvider.itemBackground
        locationContainerView.layer.cornerRadius = 5
        locationContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        locationImageView.image = UIImage(named: "pin_small")
        locationImageView.contentMode = .scaleAspectFit
        locationImageView.tintColor = DefaultColorsProvider.darkerTint
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        arrowImageView.image = UIImage(named: "right-arrow")
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.contentMode = .scaleAspectFit
        
        setupLayout()
    }
    
    fileprivate func setupLayout(){
        let titlesStackView = UIStackView()
        
        titlesStackView.addingArrangedSubviews {
            titleLabel
            subtitleLabel
        }
        
        titlesStackView.alignment(.fill).distribution(.fill).axis(.vertical).spacing(5).preparedForAutolayout()
        
        contentView.addSubview(imageView)
        contentView.addSubview(titlesStackView)

        imageView.width(50)
        imageView.heightEqualsWidth()
        imageView.Leading == contentView.Leading  + 15
        imageView.Top >= contentView.Top
        imageView.centerVertically()
        
        titlesStackView.Leading == imageView.Trailing + 15
        titlesStackView.centerVertically()
        titlesStackView.Top >= contentView.Top
        
        locationContainerView.addSubview(locationImageView)
        locationImageView.fillContainer(padding: 10)
        locationImageView.width(12).height(12)
        
        contentView.addSubview(locationContainerView)
        contentView.addSubview(arrowImageView)
        
        arrowImageView.trailing(15).height(12).width(12).centerVertically()
        locationContainerView.centerVertically()
        locationContainerView.Trailing == arrowImageView.Leading - 8
        
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.bounds.height / 2
    }
}

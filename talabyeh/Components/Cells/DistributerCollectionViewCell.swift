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
        
    enum ContentStyle {
        case customTinted(UIColor)
        case selected
        case regular
    }
    
    let titleLabel: UILabel = .init()
    let subtitleLabel: UILabel = .init()
    let imageView: UIImageView = .init()
    let arrowImageView: UIImageView = .init()
    
    let locationActionView: DistributorActionView = .init(image: UIImage(named: "plus_small"))
    let phoneActionView: DistributorActionView = .init(image: UIImage(named: "plus_small"))
    
    let titlesStackView = UIStackView()
    let actionsStackView: UIStackView = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        backgroundColor = DefaultColorsProvider.background
        layer.cornerRadius = 5.4
        dropShadow(color: .black, opacity: 0.05, offSet: .init(width: 0, height: 3.4), radius: 3.4)

        
        titleLabel.font = .font(for: .semiBold, size: 16)
        titleLabel.textColor = DefaultColorsProvider.darkerTint
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Hussein AlRyalat"
        
        subtitleLabel.font = .font(for: .regular, size: 13)
        subtitleLabel.textColor = DefaultColorsProvider.secondaryText
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.text = "best Developer in the world"
        
        imageView.backgroundColor = DefaultColorsProvider.itemBackground
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 25
        
        
        arrowImageView.image = UIImage(named: "right-arrow")
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.contentMode = .scaleAspectFit
        
        setupLayout()
    }
    
    fileprivate func setupLayout(){
        
        titlesStackView.addingArrangedSubviews {
            titleLabel
            subtitleLabel
        }
        
        titlesStackView.alignment(.fill).distribution(.fill).axis(.vertical).spacing(5).preparedForAutolayout()
        
        actionsStackView.axis(.horizontal)
            .spacing(15)
            .alignment(.fill)
            .distribution(.fillEqually)

        actionsStackView.addingArrangedSubviews {
            phoneActionView
            locationActionView
        }
        
        subviewsPreparedAL { () -> [UIView] in
            imageView
            titlesStackView
            actionsStackView
            arrowImageView
        }
        

        imageView.width(50)
        imageView.heightEqualsWidth()
        imageView.Leading == self.Leading  + 15
        imageView.Top >= self.Top
        imageView.centerVertically()
        
        titlesStackView.Leading == imageView.Trailing + 15
        titlesStackView.centerVertically()
        titlesStackView.Top >= self.Top
        
        arrowImageView.trailing(15).height(12).width(12).centerVertically()
        actionsStackView.centerVertically()
        actionsStackView.Trailing == arrowImageView.Leading - 8
        actionsStackView.Leading == titlesStackView.Trailing + 8
        
        update(style: .regular)
        layoutIfNeeded()
    }
    
    func update(style: ContentStyle){
        switch style {
        case .regular:
            titleLabel.textColor = DefaultColorsProvider.darkerTint
            subtitleLabel.textColor = DefaultColorsProvider.secondaryText
            backgroundColor = DefaultColorsProvider.background
            break
        case .selected:
            titleLabel.textColor = DefaultColorsProvider.background
            subtitleLabel.textColor = DefaultColorsProvider.background
            backgroundColor = DefaultColorsProvider.darkerTint
            break
        case .customTinted(let color):
            titleLabel.textColor = DefaultColorsProvider.background
            subtitleLabel.textColor = DefaultColorsProvider.background
            backgroundColor = color
            break
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.bounds.height / 2
    }
}

class DistributorActionView: UIView {
    
    let imageView: UIImageView = .init()
    
    init(image: UIImage?) {
        super.init(frame: .zero)
        setup()
        self.imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setup(){
        self.backgroundColor = DefaultColorsProvider.itemBackground
        self.layer.cornerRadius = 5
        
        imageView.image = UIImage(named: "pin_small")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = DefaultColorsProvider.darkerTint

        subviewsPreparedAL { () -> [UIView] in
            imageView
        }
        
        imageView.fillContainer(padding: 10)
        imageView.width(12).height(12)
    }
}

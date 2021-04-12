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
    
    let locationActionView: DistributorActionView = .init(image: UIImage(named: "distributor_location"))
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
        backgroundColor = DefaultColorsProvider.backgroundPrimary
        layer.cornerRadius = 5.4
        dropShadow(color: DefaultColorsProvider.decoratorShadow, opacity: 0.05, offSet: .init(width: 0, height: 3.4), radius: 3.4)

        
        titleLabel.font = .font(for: .semiBold, size: 16)
        titleLabel.textColor = DefaultColorsProvider.tintPrimary
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Hussein AlRyalat"
        
        subtitleLabel.font = .font(for: .regular, size: 13)
        subtitleLabel.textColor = DefaultColorsProvider.textSecondary1
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.text = "best Developer in the world"
        
        imageView.backgroundColor = DefaultColorsProvider.containerBackground3
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
            titleLabel.textColor = DefaultColorsProvider.tintPrimary
            subtitleLabel.textColor = DefaultColorsProvider.textSecondary1
            backgroundColor = DefaultColorsProvider.backgroundPrimary
            break
        case .selected:
            titleLabel.textColor = DefaultColorsProvider.backgroundPrimary
            subtitleLabel.textColor = DefaultColorsProvider.backgroundPrimary
            backgroundColor = DefaultColorsProvider.tintPrimary
            break
        case .customTinted(let color):
            titleLabel.textColor = DefaultColorsProvider.backgroundPrimary
            subtitleLabel.textColor = DefaultColorsProvider.backgroundPrimary
            backgroundColor = color
            break
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.bounds.height / 2
    }
}

class DistributorWithCheckboxCollectionViewCell: DistributerCollectionViewCell {
    
    var checkboxView: UIImageView = .init()
    
    override func setup(){
        super.setup()
        
        locationActionView.isHidden = true
        phoneActionView.isHidden = true
        
        checkboxView.layer.cornerRadius = 16
        checkboxView.layer.borderWidth = 1
        checkboxView.layer.borderColor = DefaultColorsProvider.decoratorBorder.cgColor
        
        actionsStackView.addArrangedSubview(checkboxView)
        checkboxView.width(32).height(32)
        
        update(style: .regular)
    }
    
    override func update(style: ContentStyle){
        switch style {
        case .regular:
            checkboxView.image = nil
            break
        case .selected:
            checkboxView.image = UIImage(named: "checkbox-big")
            break
        default:
            super.update(style: style)
        }
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
        self.backgroundColor = DefaultColorsProvider.containerBackground3
        self.layer.cornerRadius = 5
        
        imageView.image = UIImage(named: "pin_small")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = DefaultColorsProvider.tintPrimary

        subviewsPreparedAL { () -> [UIView] in
            imageView
        }
        
        imageView.fillContainer(padding: 10)
        imageView.width(12).height(12)
    }
}

extension DistributerCollectionViewCell: CLComponentPreview {
    static var groupIdentifier: CLComponentGroupIdentifier {
        .cells
    }
    
    static func render(in context: CLComponentPreviewContext) {
        let view: Self = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        context.containerView.addSubview(view)
        
        view.top(20).bottom(20)
        view.leading(20)
        view.centerHorizontally()
    }
}

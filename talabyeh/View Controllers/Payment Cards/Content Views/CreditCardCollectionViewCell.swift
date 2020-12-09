//
//  CreditCardCollectionViewCell.swift
//  talabyeh
//
//  Created by Hussein Work on 08/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class CreditCardCollectionViewCell: UICollectionViewCell {
    
    enum Style {
        case placeholder
        case credit
        
        func reversed() -> Style {
            self == .placeholder ? .credit : .placeholder
        }
    }
    
    var style: Style = .credit {
        didSet {
            _updateForStyle()
        }
    }
    
    let interGroupSpacing: CGFloat = 15
    
    lazy var cardContainerView = CardContainerView(title: nil, contentView: cardContentView)
    
    let cardContentView: UIView = UIView()
    let titleLabel: UILabel = .init()
    let cardNumberTitleLabel: UILabel = .init()
    let cardNumberLabel: UILabel = .init()
    let dateTitleLabel: UILabel = .init()
    let dateLabel: UILabel = .init()
    let nameLabel: UILabel = .init()
    let logoImageView: UIImageView = .init()
    
    let placeholderImageView: UIImageView = .init()
    let placeholderTitleLabel: UILabel = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        contentView.subviewsPreparedAL {
            cardContainerView
        }
        cardContainerView.fillContainer()
        
        cardContentView.subviewsPreparedAL {
            titleLabel
            cardNumberTitleLabel
            cardNumberLabel
            dateTitleLabel
            dateLabel
            nameLabel
            logoImageView
        }
        
        titleLabel.font = .font(for: .semiBold, size: 19)
        titleLabel.text = "Commercial Bank"
        
        cardNumberTitleLabel.font = .font(for: .regular, size: 12)
        cardNumberTitleLabel.text = "Card Number"
        cardNumberTitleLabel.textColor = DefaultColorsProvider.secondaryText
        
        cardNumberLabel.text = "• • • • • • • • • • • • 4567"
        cardNumberLabel.font = .font(for: .medium, size: 15)
        
        dateTitleLabel.font = .font(for: .regular, size: 12)
        dateTitleLabel.text = "Month / Year"
        dateTitleLabel.textColor = DefaultColorsProvider.secondaryText

        
        dateLabel.font = .font(for: .medium, size: 15)
        dateLabel.text = "17/2018"
        
        nameLabel.font = .font(for: .medium, size: 15)
        nameLabel.text = "Hussein AlRyalat"
        
        logoImageView.contentMode = .scaleAspectFit
        
        placeholderTitleLabel.font = .font(for: .medium, size: 15)
        placeholderTitleLabel.text = "Add a card"
        placeholderTitleLabel.textAlignment = .center
        placeholderTitleLabel.textColor = DefaultColorsProvider.secondaryText
        
        
        placeholderImageView.image = UIImage(named: "card-plus")
        placeholderImageView.contentMode = .scaleAspectFit
        
        cardContentView.subviewsPreparedAL {
            placeholderImageView
            placeholderTitleLabel
        }
        
        placeholderImageView.centerVertically(offset: -7.5).width(30).height(30).centerHorizontally()
        placeholderTitleLabel.centerVertically(offset: 7.5 + 15).centerHorizontally()
        
        // layout
        titleLabel.leading(0).trailing(0).top(0)
        
        cardNumberTitleLabel.Top == titleLabel.Bottom + interGroupSpacing
        cardNumberTitleLabel.leading(0).trailing(0)
        
        cardNumberLabel.Top == cardNumberTitleLabel.Bottom + 5
        cardNumberLabel.leading(0).trailing(0)
        
        dateTitleLabel.Top == cardNumberLabel.Bottom + interGroupSpacing
        dateTitleLabel.leading(0).trailing(0)
        
        dateLabel.Top == dateTitleLabel.Bottom + 5
        dateLabel.leading(0).trailing(0)
        
        
        logoImageView.Top == dateLabel.Bottom + interGroupSpacing
        logoImageView.width(100).height(25).trailing(0).bottom(0)
        
        nameLabel.leading(0)
        nameLabel.Trailing == logoImageView.Leading - 15
        nameLabel.CenterY == logoImageView.CenterY
        
        
        _updateForStyle()
    }
    
    fileprivate func _updateForStyle(){
        let views = self.views(for: self.style)
        let viewsToHide = self.views(for: self.style.reversed())
        
        views.forEach {
            $0.isHidden = false
        }
        
        viewsToHide.forEach {
            $0.isHidden = true
        }
    }
    
    func views(for style: Style) -> [UIView] {
        switch style {
        case .credit:
            return [
                titleLabel,
                cardNumberTitleLabel,
                cardNumberLabel,
                dateTitleLabel,
                dateLabel,
                nameLabel,
                logoImageView
            ]
        case .placeholder:
            return [
                placeholderImageView,
                placeholderTitleLabel
            ]
        }
    }
}

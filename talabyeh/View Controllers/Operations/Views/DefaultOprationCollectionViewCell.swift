//
//  DefaultOprationCollectionViewCell.swift
//  talabyeh
//
//  Created by Hussein Work on 11/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class DefaultOprationCollectionViewCell: BaseOprationCollectionViewCell {
    
    let headerView = DefaultOperationHeaderView()
    let dividerView = DividerView()
    let totalField = FieldView(contentView: UILabel(), title: "Est. Total")
    
    override var indexForInjectingContent: Int {
        containerStackView.arrangedSubviews.firstIndex(of: headerView) ?? 0
    }
    
    override func setup() {
        super.setup()
        
        containerStackView.addingArrangedSubviews {
            headerView
            dividerView
            totalField
        }
        
                
        totalField.titleLabel.textColor = DefaultColorsProvider.tintPrimary
        totalField.contentView.textColor = DefaultColorsProvider.tintPrimary
        
        containerStackView.setCustomSpacing(15, after: headerView)
        containerStackView.setCustomSpacing(15, after: dividerView)
    }
}

class DefaultOperationHeaderView: BasicViewWithSetup {
    let imageView: UIImageView = .init()
    let titleLabel: UILabel = .init()
    let statusImageView: UIImageView = .init()
    let timeLabel: UILabel = .init()
    let timeTitleLabel: UILabel = .init()
    
    
    override func setup() {
        subviewsPreparedAL {
            imageView
            titleLabel
            statusImageView
            timeLabel
            timeTitleLabel
        }
        
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = DefaultColorsProvider.tintPrimary
        imageView.image = UIImage(named: "operation-logo")
        
        titleLabel.font = .font(for: .bold, size: 22)
        titleLabel.text = "Catssss Market"
        titleLabel.textColor = DefaultColorsProvider.tintPrimary
        
        statusImageView.contentMode = .scaleAspectFit
        
        timeLabel.font = .font(for: .bold, size: 22)
        timeLabel.text = "18:00"
        timeLabel.textColor = DefaultColorsProvider.tintPrimary
        timeLabel.textAlignment = .right

        timeTitleLabel.font = .font(for: .bold, size: 12)
        timeTitleLabel.text = "Order time"
        timeTitleLabel.textColor = DefaultColorsProvider.tintPrimary
        timeTitleLabel.textAlignment = .right


        imageView.width(25).height(25).centerVertically().leading(0)
        
        titleLabel.top(0).bottom(0).centerVertically()
        titleLabel.Leading == imageView.Trailing + 15
        
        timeLabel.trailing(0).top(0)
        timeTitleLabel.Top == timeLabel.Bottom
        timeTitleLabel.trailing(0).bottom(0)
        
        statusImageView.Trailing == timeLabel.Leading - 15
        statusImageView.width(25).height(25).centerVertically()
        
        titleLabel.Trailing == statusImageView.Leading - 15
    }
}

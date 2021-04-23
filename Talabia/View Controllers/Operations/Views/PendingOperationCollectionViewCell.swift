//
//  PendingOperationCollectionViewCell.swift
//  talabyeh
//
//  Created by Hussein Work on 11/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class PendingOperationCollectionViewCell: BaseOprationCollectionViewCell {
    
    override var backgroundType: BaseOprationCollectionViewCell.BackgroundType {
        /**
         This will be changed later to support dark mode.
         */
        .solid(DefaultColorsProvider.containerBackground5)
    }
    
    // components
    let headerView = PendingOperationHeaderView()
    let titleLabel = UILabel()
    let subtotalField = FieldView(contentView: UILabel(), title: "Subtotal (15 items)")
    let dividerView = DividerView()
    let totalField = FieldView(contentView: UILabel(), title: "Est. Total")
    let orderTimeField = FieldView(contentView: UILabel(), title: "Order Time")
    let confirmView = PendingOperationConfirmationView()
    
    override var indexForInjectingContent: Int {
        containerStackView.arrangedSubviews.firstIndex(of: titleLabel) ?? 0
    }
    
    override func setup() {
        super.setup()
        
        containerStackView.addingArrangedSubviews {
            headerView
            titleLabel
            subtotalField
            dividerView
            totalField
            orderTimeField
            confirmView
        }
        
        titleLabel.text = "Cart Summary"
        titleLabel.textColor = DefaultColorsProvider.backgroundPrimary
        
        [subtotalField, totalField, orderTimeField].forEach {
            $0.titleLabel.textColor = DefaultColorsProvider.backgroundPrimary
            $0.contentView.textColor = DefaultColorsProvider.backgroundPrimary
        }
        
        containerStackView.setCustomSpacing(15, after: headerView)
        containerStackView.setCustomSpacing(15, after: dividerView)
        containerStackView.setCustomSpacing(15, after: orderTimeField)
    }
}


class PendingOperationHeaderView: BasicViewWithSetup {
    let imageView: UIImageView = .init()
    let titleLabel: UILabel = .init()
    let callButton: UIButton = .init()
    let mapButton: UIButton = .init()
    
    
    override func setup() {
        subviewsPreparedAL {
            imageView
            titleLabel
            callButton
            mapButton
        }
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "operation-logo")
        imageView.tintColor = DefaultColorsProvider.backgroundPrimary
        
        titleLabel.font = .font(for: .bold, size: 22)
        titleLabel.text = "Catssss Market"
        titleLabel.textColor = DefaultColorsProvider.backgroundPrimary
        
        callButton.backgroundColor = DefaultColorsProvider.backgroundPrimary
        mapButton.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        imageView.width(25).height(25).centerVertically().leading(0)
        
        titleLabel.top(0).bottom(0).centerVertically()
        titleLabel.Leading == imageView.Trailing + 15
        
        mapButton.trailing(0).top(0).width(30).height(30).centerVertically()
        callButton.width(30).height(30).centerVertically()
        
        callButton.Trailing == mapButton.Leading - 15
        titleLabel.Trailing == callButton.Leading - 15
    }
}

class PendingOperationConfirmationView: BasicViewWithSetup {
    let confirmButton: UIButton = .init()
    let rejectButton: UIButton = .init()
    
    override func setup() {
        subviewsPreparedAL {
            confirmButton
            rejectButton
        }
        
        [confirmButton, rejectButton].forEach {
            $0.backgroundColor = DefaultColorsProvider.backgroundPrimary
            $0.layer.cornerRadius = 10
            $0.titleLabel?.font = .font(for: .bold, size: 22)
            $0.setTitleColor(DefaultColorsProvider.textPrimary1, for: .normal)
            $0.contentEdgeInsets = .init(top: 5, left: 20, bottom: 5, right: 20)
        }
        
        confirmButton.width(45%).leading(0).top(0).bottom(0)
        rejectButton.width(45%).trailing(0).top(0).bottom(0)
        
        confirmButton.setTitle("Confirm", for: .normal)
        rejectButton.setTitle("Reject", for: .normal)
    }
}

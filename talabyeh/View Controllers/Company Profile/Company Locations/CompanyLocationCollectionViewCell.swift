//
//  CompanyLocationCollectionViewCell.swift
//  talabyeh
//
//  Created by Hussein Work on 16/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class CompanyLocationCollectionViewCell: UICollectionViewCell {
        
    let titleLabel: UILabel = .init()
    
    let subtitleLabel: UILabel = .init()

    let leftItemsStackView: UIStackView = .init()
    let actionsStackView: UIStackView = .init()
    
    let editButton: UIButton = .init()
    let removeButton: UIButton = .init()
    let mapButton: UIButton = .init()
    
    var labelViews: [LabelView] = []
    
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
        
        subviewsPreparedAL {
            leftItemsStackView
            actionsStackView
        }
        
        leftItemsStackView.width(65%).leading(20).top(20).bottom(20)
        actionsStackView.width(25%).trailing(20).top(20).bottom(>=20)
        
        leftItemsStackView
            .axis(.vertical)
            .spacing(8)
            .alignment(.fill)
            .distribution(.fill)
        
        
        
        actionsStackView
            .axis(.vertical)
            .alignment(.fill)
            .distribution(.fillEqually)
            .spacing(15)
        
        // now setup the contents
        titleLabel.font = .font(for: .bold, size: 22)
        titleLabel.textColor = DefaultColorsProvider.text
        titleLabel.text = "City Name"
        
        subtitleLabel.text = "Full Adress\nFull Adress"
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textColor = DefaultColorsProvider.secondaryText
        
        [editButton, removeButton].forEach {
            $0.backgroundColor = DefaultColorsProvider.darkerTint
            $0.layer.cornerRadius = 11
            $0.setTitleColor(DefaultColorsProvider.background, for: .normal)
            $0.contentEdgeInsets = .init(top: 5, left: 10, bottom: 5, right: 10)
            $0.titleLabel?.font = .font(for: .bold, size: 16)
        }
        
        editButton.setTitle("Edit", for: .normal)
        removeButton.setTitle("Remove", for: .normal)
        
        mapButton.setTitle("Map", for: .normal)
        mapButton.setTitleColor(DefaultColorsProvider.darkerTint, for: .normal)
        mapButton.layer.cornerRadius = 11
        mapButton.layer.borderWidth = 0.2
        mapButton.layer.borderColor = DefaultColorsProvider.darkerTint.cgColor
        mapButton.contentEdgeInsets = .init(top: 5, left: 10, bottom: 5, right: 10)
        mapButton.backgroundColor = DefaultColorsProvider.background
                
        leftItemsStackView.addingArrangedSubviews {
            titleLabel
            subtitleLabel
        }
        
        actionsStackView.addingArrangedSubviews {
            editButton
            removeButton
            mapButton
        }
        
        leftItemsStackView.setCustomSpacing(20, after: subtitleLabel)
        actionsStackView.setCustomSpacing(35, after: removeButton)
        
        insert(labelView: LabelView(title: "+96 79 00000000", icon: UIImage(named: "pin_small")))
        insert(labelView: LabelView(title: "+96 79 00000000", icon: UIImage(named: "pin_small")))
    }
    
    fileprivate func insert(labelView: LabelView){
        labelViews.append(labelView)
        
        labelView.titleLabel.textColor = DefaultColorsProvider.text
        labelView.titleLabel.font = .font(for: .medium, size: 14)

        let beginTargetIndex = leftItemsStackView.arrangedSubviews.firstIndex(of: subtitleLabel) ?? 0
        leftItemsStackView.insertArrangedSubview(labelView, at: beginTargetIndex + labelViews.count)
    }
}

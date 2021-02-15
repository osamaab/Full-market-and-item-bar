//
//  CompanyBranchCollectionViewCell.swift
//  talabyeh
//
//  Created by Hussein Work on 08/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

class CompanyBranchCollectionViewCell: UICollectionViewCell {
    
    let containerStackView = UIStackView().then {
        $0.alignment(.fill)
            .distribution(.fill)
            .axis(.vertical)
            .spacing(15)
    }
    
    let actionsStackView = UIStackView().then {
        $0.alignment(.fill)
            .distribution(.fill)
            .axis(.vertical)
            .spacing(15)
    }
    
    
    let titleLabel: UILabel = UILabel().then {
        $0.font = .font(for: .bold, size: 22)
        $0.textColor = DefaultColorsProvider.textPrimary1
    }
    
    let subtitleLabel = UILabel().then {
        $0.font = .font(for: .semiBold, size: 14)
        $0.textColor = DefaultColorsProvider.textSecondary1
        $0.numberOfLines = 0
    }
    
    let editButton = UIButton().then {
        $0.backgroundColor = DefaultColorsProvider.tintPrimary
        $0.layer.cornerRadius = 10
        $0.setTitle("Edit", for: .normal)
        $0.setTitleColor(DefaultColorsProvider.backgroundPrimary, for: .normal)
        $0.titleLabel?.font = .font(for: .bold, size: 16)
        $0.contentEdgeInsets = .init(top: 8, left: 20, bottom: 8, right: 20)
    }

    let mapButton = UIButton().then {
        $0.backgroundColor = DefaultColorsProvider.backgroundPrimary
        $0.layer.cornerRadius = 10
        $0.setTitle("Map", for: .normal)
        $0.setTitleColor(DefaultColorsProvider.tintPrimary, for: .normal)
        $0.titleLabel?.font = .font(for: .bold, size: 16)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = DefaultColorsProvider.tintPrimary.cgColor
        $0.contentEdgeInsets = .init(top: 8, left: 20, bottom: 8, right: 20)
    }
    
    let summaryLabel = UILabel().then {
        $0.font = .font(for: .medium, size: 18)
        $0.textColor = DefaultColorsProvider.tintPrimary
        $0.numberOfLines = 0
    }
    
    
    
    
    var onMapTap: ActionBlock?
    var onEditTap: ActionBlock?
    
    
    fileprivate var labelsViews: [LabelView] = []
    
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
        
        subviewsPreparedAL {
            containerStackView
            actionsStackView
        }
        
        containerStackView.top(20).leading(20).bottom(20)//.width(65%)
        actionsStackView.top(20).trailing(20).bottom(>=20)
        actionsStackView.Leading == containerStackView.Trailing + 15
        
        containerStackView.addingArrangedSubviews {
            titleLabel
            subtitleLabel
            // no label views for now, to be added later..
            summaryLabel
        }
        
        actionsStackView.addingArrangedSubviews {
            editButton
            mapButton
        }
        
        
        editButton.add(event: .touchUpInside){ [unowned self] in
            self.onEditTap?()
        }
        
        mapButton.add(event: .touchUpInside){ [unowned self] in
            self.onMapTap?()
        }
        
        layer.cornerRadius = 10
        dropShadow(color: UIColor.lightGray,
                   opacity: 0.16,
                   offSet: .init(width: 0, height: 3.4), radius: 3.4)
            
        insertLabelView(with: "+96 79 00000000", icon: UIImage(named: "clock_small"))
        insertLabelView(with: "+96 79 00000000", icon: UIImage(named: "clock_small"))
        insertLabelView(with: "+96 79 00000000", icon: UIImage(named: "clock_small"))
        insertLabelView(with: "+96 79 00000000", icon: UIImage(named: "clock_small"))
        insertLabelView(with: "+96 79 00000000", icon: UIImage(named: "clock_small"))
    }
    
    func insertLabelView(with title: String, icon: UIImage?){
        let newLabelView = LabelView(title: title, icon: icon)
        newLabelView.titleLabel.font = .font(for: .medium, size: 14)
        newLabelView.titleLabel.textColor = DefaultColorsProvider.textPrimary1
        newLabelView.imageView.tintColor = DefaultColorsProvider.textSecondary1
        
        labelsViews.append(newLabelView)
        
        containerStackView.insertArrangedSubview(newLabelView, at: containerStackView.arrangedSubviews.firstIndex(of: summaryLabel)!)
    }
    
    func set(items: [StoreLocation.DetailItem]){
        let labelsViews = self.labelsViews
                
        items.reversed().enumerated().forEach {
            let index = $0.offset
            let element = $0.element
            
            if index < labelsViews.count {
                labelsViews[index].icon = UIImage(named: "store_\(element.identifier.rawValue)")
                labelsViews[index].titleLabel.text = element.text
            }
        }
    }
}

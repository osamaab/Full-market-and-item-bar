//
//  ClientPreferOperationAccessoryView.swift
//  talabyeh
//
//  Created by Hussein Work on 13/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class ClientPreferOperationAccessoryView: BasicViewWithSetup {
    
    let titleLabel: UILabel = .init()
    let topImageView: UIImageView = .init()
    
    let distributerContentView: DistributerCollectionViewCell = .init()
    
    let actionButton: UIButton = .init()
    let alternativeButton: UIButton = .init()
    
    override func setup() {
        backgroundColor = DefaultColorsProvider.lightTint
        layer.cornerRadius = 10
        
        titleLabel.text = "Client Prefere"
        titleLabel.textColor = DefaultColorsProvider.darkerTint
        titleLabel.font = .font(for: .bold, size: 22)
        
        topImageView.contentMode = .scaleAspectFit
        topImageView.image = UIImage(named: "Group 2106")
        
        distributerContentView.layer.shadowOpacity = 0
        distributerContentView.layer.cornerRadius = 10
        distributerContentView.clipsToBounds = true

        
        actionButton.setTitle("Okay", for: .normal)
        actionButton.setTitleColor(DefaultColorsProvider.background, for: .normal)
        actionButton.backgroundColor = DefaultColorsProvider.darkerTint
        actionButton.titleLabel?.font = .font(for: .bold, size: 22)
        actionButton.layer.cornerRadius = 10
        actionButton.contentEdgeInsets = .init(top: 12, left: 0, bottom: 12, right: 0)
        
        alternativeButton.setTitle("Select another ditributer", for: .normal)
        alternativeButton.setTitleColor(DefaultColorsProvider.darkerTint, for: .normal)
        alternativeButton.backgroundColor = DefaultColorsProvider.background
        alternativeButton.titleLabel?.font = .font(for: .bold, size: 22)
        alternativeButton.layer.cornerRadius = 10
        alternativeButton.contentEdgeInsets = .init(top: 12, left: 0, bottom: 12, right: 0)

        subviewsPreparedAL {
            titleLabel
            topImageView
            distributerContentView
            actionButton
            alternativeButton
        }
        
        let margin: CGFloat = 20
        let verticalMargin: CGFloat = 20
        
        titleLabel.leading(margin).top(verticalMargin + 5)
        topImageView.trailing(margin).width(30).height(30)
        distributerContentView.height(90).leading(margin).trailing(margin)
        actionButton.leading(margin).trailing(margin)
        alternativeButton.leading(margin).trailing(margin).bottom(verticalMargin + 5)
        
        titleLabel.Trailing == topImageView.Leading - verticalMargin
        titleLabel.CenterY == topImageView.CenterY
        
        distributerContentView.Top == titleLabel.Bottom + verticalMargin
        
        actionButton.Top == distributerContentView.Bottom + verticalMargin
        alternativeButton.Top == actionButton.Bottom + verticalMargin
    }
}

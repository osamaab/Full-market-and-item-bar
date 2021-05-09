//
//  NotficationCollectionViewCell.swift
//  Talabia
//
//  Created by Osama Abu hdba on 05/05/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

class NotficationCollectionViewCell: UICollectionViewCell {
    let containerView = UIView().then {
        $0.backgroundColor = DefaultColorsProvider.backgroundPrimary
        $0.clipsToBounds = false
        $0.dropShadow(color: .gray,
                      opacity: 0.3,
                                 offSet: .init(width: 0, height: 2),
                                 radius: 2)
        $0.layer.borderWidth = 2
        $0.layer.borderColor = DefaultColorsProvider.tintPrimary.cgColor
        $0.layer.cornerRadius = 10
    }
    let titleLabel = UILabel().then {
        $0.backgroundColor = DefaultColorsProvider.backgroundPrimary
        $0.textColor = UIColor(hex: "#7F9082")
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.font = .font(for: .regular, size: 17)
        $0.textAlignment = .center
       
        $0.numberOfLines = 0
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        subviewsPreparedAL {
            containerView
        }

        containerView.subviewsPreparedAL {
            titleLabel
        }
        
        containerView.leading(0).trailing(0).top(0)

       
        
        titleLabel.top(8).height(140).bottom(8)
            .leading(20).trailing(20)
        
    }


}

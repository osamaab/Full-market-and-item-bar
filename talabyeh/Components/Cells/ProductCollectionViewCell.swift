//
//  ItemCell.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class ProductCollectionViewCell: UICollectionViewCell {
    
    let containerView = UIView().then {
        $0.backgroundColor = DefaultColorsProvider.backgroundPrimary
        $0.clipsToBounds = false
        $0.layer.masksToBounds = false
        
        $0.dropShadow(color: DefaultColorsProvider.decoratorShadow,
                                 opacity: 0.16,
                                 offSet: .init(width: 0, height: 2),
                                 radius: 2)
    }
    
    let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    
    let titleLabel = UILabel().then {
        $0.font = .font(for: .medium, size: 12)
        $0.textColor = DefaultColorsProvider.tintPrimary
    }
    
    let likeButton = FavoriteButton()
    
    let topLabel = UILabel().then {
        $0.backgroundColor = DefaultColorsProvider.containerBackground3
        $0.textColor = DefaultColorsProvider.backgroundPrimary
        $0.layer.cornerRadius = 1.7
        $0.font = .font(for: .bold, size: 9)
        $0.textAlignment = .center
    }
    
    let subtitleLabel1 = UILabel().then {
        $0.font = .font(for: .medium, size: 12)
        $0.textColor = DefaultColorsProvider.textPrimary1
    }
    
    let subtitleLabel2 = UILabel().then {
        $0.font = .font(for: .bold, size: 11)
        $0.textColor = DefaultColorsProvider.textPrimary1
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
            subtitleLabel1
            subtitleLabel2
        }

        containerView.subviewsPreparedAL {
            imageView
            titleLabel
            likeButton
            topLabel
        }
        
        containerView.leading(0).trailing(0).top(0)
        
        titleLabel.bottom(5).centerHorizontally()
        titleLabel.Top == imageView.Bottom + 5

        imageView.width(100%).top(20).centerHorizontally()
        
        topLabel.leading(8).top(8).height(15).width(30)

        likeButton.trailing(8).height(20).width(20)
        likeButton.CenterY == topLabel.CenterY
        
        subtitleLabel1.leading(0).centerHorizontally()
        subtitleLabel1.Top == containerView.Bottom + 15

        
        subtitleLabel2.leading(0).centerHorizontally()
        subtitleLabel2.Top == subtitleLabel1.Bottom + 5
        subtitleLabel2.bottom(15)
    }
}

extension ProductCollectionViewCell: CLComponentPreview {
    static var groupIdentifier: CLComponentGroupIdentifier {
        .cells
    }
    
    static func render(in context: CLComponentPreviewContext) {
        let view: Self = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        context.containerView.addSubview(view)
        
        view.imageView.image = UIImage(named: "Rectangle 232")
        view.subtitleLabel1.text = "Red Onions"
        view.titleLabel.text = "New era market"
        view.subtitleLabel2.text = "JD 0.200"
        
        view.top(20).bottom(20)
        view.leading(20)
        view.centerHorizontally()
    }
}

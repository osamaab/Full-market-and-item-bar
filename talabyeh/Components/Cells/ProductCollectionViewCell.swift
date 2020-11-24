//
//  ItemCell.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit
import Stevia

class ProductCollectionViewCell: UICollectionViewCell {
    
    let containerView = UIView()
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    
    let likeButton = UIButton()
    let topLabel = UILabel()
    
    let subtitleLabel1 = UILabel()
    let subtitleLabel2 = UILabel()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        subviews {
            containerView
            subtitleLabel1
            subtitleLabel2
        }

        containerView.subviews {
            imageView
            titleLabel
            likeButton
            topLabel
        }
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel1.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel2.translatesAutoresizingMaskIntoConstraints = false

        
        containerView.backgroundColor = DefaultColorsProvider.background
        containerView.clipsToBounds = false
        containerView.layer.masksToBounds = false

        containerView.dropShadow(color: UIColor.black, opacity: 0.06, offSet: .init(width: 0, height: 2), radius: 2)
        
        
      
        titleLabel.font = .font(for: .medium, size: 12)
        titleLabel.textColor = DefaultColorsProvider.darkerTint

        
        topLabel.backgroundColor = DefaultColorsProvider.itemBackground
        topLabel.textColor = DefaultColorsProvider.background
        topLabel.layer.cornerRadius = 1.7
        topLabel.font = .font(for: .bold, size: 9)
        topLabel.textAlignment = .center

        
        likeButton.setImage(UIImage(named: "heart"), for: .normal)
        likeButton.contentMode = .scaleAspectFit
        
        
        subtitleLabel1.font = .font(for: .medium, size: 12)
        subtitleLabel1.textColor = DefaultColorsProvider.text
                
        subtitleLabel2.font = .font(for: .bold, size: 11)
        subtitleLabel2.textColor = DefaultColorsProvider.text
        
        containerView.leading(0).trailing(0).top(0).centerHorizontally()
        

        imageView.contentMode = .scaleAspectFit
        imageView.width(100%).top(20).centerHorizontally()
        
        titleLabel.bottom(5).centerHorizontally()
        titleLabel.Top == imageView.Bottom + 5

        
        topLabel.leading(8).top(8).height(15).width(30)

        
        likeButton.trailing(8).height(20).width(20)
        likeButton.CenterY == topLabel.CenterY

        
        subtitleLabel1.leading(0)
        subtitleLabel1.Top == containerView.Bottom + 15

        
        subtitleLabel2.leading(0)
        subtitleLabel2.Top == subtitleLabel1.Bottom + 5
    }
}

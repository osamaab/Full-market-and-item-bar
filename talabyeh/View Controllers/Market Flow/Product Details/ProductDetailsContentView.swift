//
//  ProductDetailsContentView.swift
//  talabyeh
//
//  Created by Hussein Work on 24/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia



class ProductDetailsContentView: UIView {
    
    let containerStackView: UIStackView = .init()
    
    let headerView: ProductHeaderView = .init()
    let ratingView: RatingView = .init()
    let quantityView: QuantitySelectionView = .init(title: "Quantity")
    let qrCodeView: QRCodeView = .init()
    let descriptionLabel: UILabel = .init()
    let additionalDetailsLabel: UILabel = .init()
    
    let alternativeButton: BorderedButton = .init()
    let actionButton: ActionButton = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        subviews {
            containerStackView
        }
        
        containerStackView.addingArrangedSubviews {
            headerView.embededInVerticalPaddingView()
            ratingView.embededInVerticalPaddingView()
            quantityView.embededInVerticalPaddingView()
            qrCodeView.embededInVerticalPaddingView(topPadding: 10, bottomPadding: 10)
            descriptionLabel
            additionalDetailsLabel
            alternativeButton
            actionButton
        }
                
        containerStackView
            .alignment(.fill)
            .distribution(.fill)
            .spacing(20)
            .axis(.vertical)
            .preparedForAutolayout()
        
        containerStackView.fillContainer(padding: 35)
        
        setupStyling()
        setupConstraints()
    }
    
    func setupStyling(){
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .font(for: .medium, size: 16)
        descriptionLabel.textColor = DefaultColorsProvider.secondaryText
        descriptionLabel.textAlignment = .center

        additionalDetailsLabel.numberOfLines = 0
        additionalDetailsLabel.font = .font(for: .bold, size: 21)
        additionalDetailsLabel.textColor = DefaultColorsProvider.text
        additionalDetailsLabel.textAlignment = .center
        

        actionButton.contentEdgeInsets = .init(top: 12, left: 0, bottom: 12, right: 0)
        alternativeButton.contentEdgeInsets = .init(top: 12, left: 0, bottom: 12, right: 0)
    }
    
    func setupConstraints(){
        qrCodeView.height(150)
        qrCodeView.Height == qrCodeView.Width
        
        headerView.imageView.height(150)
        
        containerStackView.setCustomSpacing(25, after: additionalDetailsLabel)
    }
}

/**
 Implementation is taken from the product collectionview cell
 */
class ProductHeaderView: UIView {
    
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
        
        
        titleLabel.font = .font(for: .medium, size: 17)
        titleLabel.textColor = DefaultColorsProvider.darkerTint

        
        topLabel.backgroundColor = DefaultColorsProvider.itemBackground
        topLabel.textColor = DefaultColorsProvider.background
        topLabel.layer.cornerRadius = 3
        topLabel.font = .font(for: .bold, size: 12)
        topLabel.textAlignment = .center

        
        likeButton.setImage(UIImage(named: "heart"), for: .normal)
        likeButton.contentMode = .scaleAspectFit
        
        
        subtitleLabel1.font = .font(for: .regular, size: 14)
        subtitleLabel1.textColor = DefaultColorsProvider.text
        subtitleLabel1.textAlignment = .center
                
        subtitleLabel2.font = .font(for: .bold, size: 17)
        subtitleLabel2.textColor = DefaultColorsProvider.text
        subtitleLabel2.textAlignment = .center
        
        containerView.leading(0).trailing(0).top(0).centerHorizontally()
        

        imageView.contentMode = .scaleAspectFit
        imageView.width(100%).top(20).centerHorizontally()
        
        titleLabel.Trailing == likeButton.Leading - 15
        titleLabel.bottom(15).centerHorizontally()
        titleLabel.Top == imageView.Bottom + 8

        
        topLabel.leading(8).top(8).height(25).width(40)

        
        likeButton.trailing(8).height(30).width(30)
        likeButton.CenterY == topLabel.CenterY

        
        subtitleLabel1.leading(0).centerHorizontally()
        subtitleLabel1.Top == containerView.Bottom + 15

        
        subtitleLabel2.leading(0).centerHorizontally()
        subtitleLabel2.Top == subtitleLabel1.Bottom + 5
        subtitleLabel2.bottom(0)
    }
}

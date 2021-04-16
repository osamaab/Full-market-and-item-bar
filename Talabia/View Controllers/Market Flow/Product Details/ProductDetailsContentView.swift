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
    let preferencesManager = UserDefaultsPreferencesManager.shared
    
    let headerView: ProductHeaderView = .init()
    var ratingView: RatingView = .init()
    let quantityView: QuantitySelectionView = .init(style: .big, title: "Quantity")
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
//            quantityView.embededInVerticalPaddingView()
//            qrCodeView.embededInVerticalPaddingView(topPadding: 10, bottomPadding: 10)
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
        
        descriptionLabel.font = .font(for: .regular, size: 15)
        descriptionLabel.textColor = .black
        descriptionLabel.textAlignment = .center

        additionalDetailsLabel.numberOfLines = 0
        additionalDetailsLabel.font = .font(for: .bold, size: 21)
        additionalDetailsLabel.textColor = DefaultColorsProvider.textPrimary1
        additionalDetailsLabel.textAlignment = .center
        

        actionButton.contentEdgeInsets = .init(top: 12, left: 0, bottom: 12, right: 0)
        actionButton.clipsToBounds = true
        actionButton.layer.cornerRadius = 13
        alternativeButton.contentEdgeInsets = .init(top: 12, left: 0, bottom: 12, right: 0)
        alternativeButton.clipsToBounds = true
        alternativeButton.layer.cornerRadius = 13
        
//        if preferencesManager.userType == .company {
//            actionButton.removeFromSuperview()
//            alternativeButton.removeFromSuperview()
//        }
    }
    
    func setupConstraints(){
        qrCodeView.height(150)
        qrCodeView.Height == qrCodeView.Width
        
        actionButton.width(250)
//        alternativeButton.width(250)
        
//        containerStackView.leading(35).trailing(35).bottom(35).top(35)
//        self.leading(0).trailing(0).bottom(0).top(0)
        headerView.imageView.height(150)
        containerStackView.setCustomSpacing(25, after: additionalDetailsLabel)
        containerStackView.centerHorizontally()
        descriptionLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        descriptionLabel.setContentHuggingPriority(.defaultLow, for: .vertical)

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
            titleLabel
            subtitleLabel1
            subtitleLabel2
            
        }

        containerView.subviews {
            imageView
//            titleLabel
            topLabel
        }
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel1.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel2.translatesAutoresizingMaskIntoConstraints = false

        
        containerView.backgroundColor = DefaultColorsProvider.backgroundPrimary
        containerView.clipsToBounds = false
        containerView.layer.masksToBounds = false
        containerView.layer.cornerRadius = 13
        containerView.width(260).height(200)

        containerView.dropShadow(color: .gray,
                                 opacity: 0.2,
                                 offSet: .init(width: 0, height: 2),
                                 radius: 2)
        
        
        titleLabel.font = .font(for: .bold, size: 17)
        titleLabel.textColor = .black

        
        topLabel.backgroundColor = DefaultColorsProvider.containerBackground1
        topLabel.textColor = DefaultColorsProvider.backgroundPrimary
        topLabel.layer.cornerRadius = 5
//        topLabel.numberOfLines = 1
        topLabel.clipsToBounds = true
        topLabel.font = .font(for: .bold, size: 15)
        topLabel.textAlignment = .center

        
//        likeButton.setImage(UIImage(named: "heart"), for: .normal)
//        likeButton.contentMode = .scaleAspectFit
//
        
         
        subtitleLabel1.font = .font(for: .bold, size: 17)
        subtitleLabel1.textColor = DefaultColorsProvider.textPrimary1
        subtitleLabel1.textAlignment = .center
                
        subtitleLabel2.font = .font(for: .bold, size: 17)
        subtitleLabel2.textColor = DefaultColorsProvider.textPrimary1
        subtitleLabel2.textAlignment = .center
        
        containerView.leading(0).trailing(0).top(0).centerHorizontally()
        containerView.height(200)

        imageView.contentMode = .scaleAspectFit
        imageView.width(100%).bottom(10).leading(0).trailing(0)
        
         
        titleLabel.centerHorizontally()
        titleLabel.Top == containerView.Bottom + 20
//        titleLabel.leading(90).trailing(90)

        
        topLabel.leading(16).top(16).height(25).width(40)
    
        subtitleLabel1.leading(0).centerHorizontally()
        subtitleLabel1.Top ==  titleLabel.Bottom + 5

        subtitleLabel2.leading(0).centerHorizontally()
        subtitleLabel2.Top == subtitleLabel1.Bottom + 5
        subtitleLabel2.bottom(0)
    }
}

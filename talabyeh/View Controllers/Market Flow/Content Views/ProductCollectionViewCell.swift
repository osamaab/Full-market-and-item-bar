//
//  ItemCell.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit
import Stevia

class ProductCollectionViewCell: UICollectionViewCell{
    
    let cView = UIView()
    let itemImage = UIImageView()
    let itemSeller = UILabel()
    let likeButton = UIButton()
    let weightLabel = UILabel()
    
    let itemTitle = UILabel()
    let itemPrice = UILabel()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        
        self.subviews([cView, itemTitle, itemPrice])
        
        cView.backgroundColor = DefaultColorsProvider.background
        cView.layer.borderWidth = 0.2
        cView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cView.layer.cornerRadius = 0.91
        cView.leading(0).trailing(0).top(0).height(130.16).centerHorizontally()
        
        // cView
        cView.subviews([itemImage, itemSeller, likeButton, weightLabel])
        itemImage.contentMode = .scaleAspectFit
        itemImage.width(100%).height(84.73).top(18.71).centerHorizontally()
        itemSeller.font = currentLanguage == .en ? getEnglishFont(12, .medium): getArabicFont(12, .regular)
        itemSeller.textColor = UIColor(named: AdaptiveColors.green.rawValue)
        itemSeller.height(14).centerHorizontally()
        itemSeller.Top == itemImage.Bottom + 5.5
        
        weightLabel.backgroundColor = UIColor(named: AdaptiveColors.darkGrey.rawValue)
        weightLabel.textColor = UIColor(named: AdaptiveColors.white.rawValue)
        weightLabel.layer.cornerRadius = 1.7
        weightLabel.font = currentLanguage == .en ? getEnglishFont(9, .bold): getArabicFont(9, .bold)
        weightLabel.textAlignment = .center
        weightLabel.leading(8).top(8).height(15).width(28.27)
        
        likeButton.setImage(UIImage(named: "heart"), for: .normal)
        likeButton.contentMode = .scaleAspectFit
        likeButton.trailing(8).height(17.92).width(20.03)
        likeButton.CenterY == weightLabel.CenterY
        //
        
        itemTitle.font = currentLanguage == .en ? getEnglishFont(12, .medium): getArabicFont(12, .regular)
        itemTitle.textColor = UIColor(named: AdaptiveColors.black.rawValue)
        itemTitle.height(14).leading(0)
        itemTitle.Top == cView.Bottom + 6.78
        
        itemPrice.font = currentLanguage == .en ? getEnglishFont(11, .bold): getArabicFont(11, .bold)
        itemPrice.textColor = UIColor(named: AdaptiveColors.black.rawValue)
        itemPrice.height(13).leading(0)
        itemPrice.Top == itemTitle.Bottom + 4.39
    }
}

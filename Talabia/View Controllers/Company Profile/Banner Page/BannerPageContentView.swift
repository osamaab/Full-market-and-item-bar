//
//  BannerPageContentView.swift
//  Talabia
//
//  Created by Osama Abu hdba on 04/05/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia


class BannerPageContentView: BasicViewWithSetup{
    
    let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "banner_PlaceHolder")
    }
    let titleLabel = UILabel().then {
        $0.font = .font(for: .bold, size: 17)
        $0.textColor = .white
        $0.textAlignment = .left
        $0.text = "Delivery chart 2 JD"
    }
    let infoButton = UIButton().then {
        $0.backgroundColor = .white
        $0.setImage(UIImage(named: "menu_info"), for: .normal)
        $0.layer.cornerRadius = 5
        
    }
    let contanerView = UIView().then{
        $0.backgroundColor = .gray
    }
    
    let addPicButton = UIButton().then {
        $0.backgroundColor = DefaultColorsProvider.tintSecondary
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
        $0.setTitle("Upload Picture", for: .normal)
        $0.titleLabel?.font = .font(for: .regular, size: 17)
        $0.setTitleColor(DefaultColorsProvider.tintPrimary, for: .normal)
        $0.titleEdgeInsets.left = -260
        $0.titleLabel?.textAlignment = .left
        $0.setImage(UIImage(named: "three_dots"), for: .normal)
        $0.imageEdgeInsets.right = -410
        $0.imageEdgeInsets.bottom = -2
    }
    
     override func setup() {
        subviewsPreparedAL {
            contanerView
            addPicButton
        }
        
        contanerView.subviewsPreparedAL{
            imageView
            titleLabel
            infoButton
        }
       
        contanerView.top(0)
        contanerView.height(136)
        contanerView.leading(0).trailing(0)
        
        imageView.Width == contanerView.Width
        imageView.Height == contanerView.Height
        imageView.top(0).leading(0).trailing(0)
        imageView.height(136)

        titleLabel.height(20)
        titleLabel.leading(10)
        titleLabel.bottom(7)
        
        addPicButton.Top == contanerView.Bottom + 20
        addPicButton.Trailing == contanerView.Trailing - 5
        addPicButton.Leading == contanerView.Leading + 5
        addPicButton.height(44).bottom(20)
       
        
        infoButton.width(30).height(30).trailing(10).bottom(5)
    }
}

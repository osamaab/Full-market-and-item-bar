//
//  CompanyBannerCollectionViewCell.swift
//  Talabia
//
//  Created by Osama Abu hdba on 19/04/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia
class CompanyBannerCollectionViewCell: UICollectionViewCell {

    let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        subviewsPreparedAL {
            imageView
            titleLabel
            infoButton
        }
        
       
        view.height(140)
        imageView.Width == view.Width
        imageView.Height == view.Height
        imageView.top(0).leading(0).trailing(0)

        titleLabel.height(20)
        titleLabel.Leading == imageView.Leading + 5
        titleLabel.bottom(5)
        
        infoButton.width(30).height(30).trailing(10).bottom(5)
    }
}

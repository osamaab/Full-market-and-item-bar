//
//  BannerViewSectionHeader.swift
//  talabyeh
//
//  Created by Hussein Work on 25/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit

class BannerViewSectionHeader: UICollectionReusableView {

    let imageView1: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    let imageView2: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    var isFlipped = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        subviewsPreparedAL { () -> [UIView] in
            imageView1
            imageView2
        }
        
        imageView1.top(0).leading(-5).trailing(-5).height(140)
        imageView2.top(0).leading(-5).trailing(-5).height(140)
    }
    func flipUp(speed:TimeInterval = 5) {
        
        // Flip up animation
        UIView.transition(from: imageView1, to: imageView2, duration: speed, options: [.showHideTransitionViews,.transitionFlipFromLeft], completion: nil)
        
        // Set the status of the card
        isFlipped = true
    }
    
    func flipDown(speed:TimeInterval = 20) {
        
        // Flip down animation
        UIView.transition(from: imageView2, to: imageView1, duration: speed, options: [.showHideTransitionViews,.transitionFlipFromLeft], completion: nil)
        imageView2.alpha = 0 
        // Set the status of the card
        isFlipped = false
    }
}

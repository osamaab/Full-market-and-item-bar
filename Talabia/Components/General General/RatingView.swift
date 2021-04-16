//
//  RatingView.swift
//  talabyeh
//
//  Created by Hussein Work on 24/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Cosmos

class RatingView: UIView {
    weak var ratingSlider: UISlider!
   
   
    var rating: Double = 3 {
        didSet {
            self.ratingView.rating = rating
        }
    }

    let ratingView: CosmosView = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
      
    }
    
    func setup(){
        var settings = CosmosSettings()
        settings.emptyBorderWidth = 0
        settings.emptyColor = DefaultColorsProvider.backgroundSecondary
        settings.fillMode = .half
        settings.filledBorderWidth = 0
        settings.filledColor = DefaultColorsProvider.messageRating
        settings.updateOnTouch = true
        settings.disablePanGestures = true
        
        ratingView.settings = settings
        
        ratingView.rating = rating
        
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(ratingView)
        ratingView.fillContainer()
    }
    
}

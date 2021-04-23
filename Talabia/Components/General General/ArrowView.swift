//
//  ArrowView.swift
//  talabyeh
//
//  Created by Hussein Work on 24/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit

class ArrowImageView: UIImageView {

    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        self.image = UIImage(named: "right-arrow")
        self.tintColor = DefaultColorsProvider.elementUnselected
        self.contentMode = .scaleAspectFit
        
        if isRTL {
            self.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
    }
}

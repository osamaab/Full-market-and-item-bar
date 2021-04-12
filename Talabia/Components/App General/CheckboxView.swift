//
//  CheckboxView.swift
//  talabyeh
//
//  Created by Hussein Work on 20/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class CheckboxView: UIImageView {

    var isSelected: Bool = false {
        didSet {
            
            image = isSelected ? UIImage(named: "checkbox_selected") : UIImage(named: "check_empty")
           
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.clipsToBounds = true
        image = isSelected ? UIImage(named: "checkbox_selected") : UIImage(named: "check_empty")
        let radius = self.frame.width/2.0
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = true
    }
}

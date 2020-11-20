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
            image = isSelected ? UIImage(named: "checkbox_selected") : UIImage(named: "checkbox_unselecteed")
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        image = isSelected ? UIImage(named: "checkbox_selected") : UIImage(named: "checkbox_unselecteed")
    }
}

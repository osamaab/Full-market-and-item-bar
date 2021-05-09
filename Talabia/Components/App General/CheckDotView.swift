//
//  CheckDotView.swift
//  Talabia
//
//  Created by Osama Abu hdba on 05/05/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
class CheckDotView: UIImageView {
var isSelected: Bool = false {
    didSet {
        
        image = isSelected ? UIImage(named: "check_dot") : UIImage(named: "unCheck_dot")
       
    }
}

override func didMoveToSuperview() {
    super.didMoveToSuperview()
    self.clipsToBounds = true
    image = isSelected ? UIImage(named: "check_dot") : UIImage(named: "unCheck_dot")
    let radius = self.frame.width/2.0
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
}
}

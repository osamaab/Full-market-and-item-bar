//
//  CheckboxLabelView.swift
//  talabyeh
//
//  Created by Hussein Work on 08/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit

class CheckboxLabelView: LabelView {

    var isChecked: Bool = false {
        didSet {
            icon = isChecked ? UIImage(named: "checkbox_selected") : UIImage(named: "checkbox_unselecteed")
        }
    }
    
    override func setup() {
        super.setup()
        isChecked = false
        
        add(gesture: .tap(1)) { [unowned self] in
            self.isChecked = !self.isChecked
        }
    }
}

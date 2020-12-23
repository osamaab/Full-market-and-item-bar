//
//  PriceTextField.swift
//  talabyeh
//
//  Created by Hussein Work on 22/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class PriceTextField: BorderedTextField {

    let unitLabel: UILabel = .init()
    
    fileprivate func updateInsets(){
        let originalInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        var modifited = originalInset
        
        let padding: CGFloat = 20
        
        if isRTL {
            modifited.left += padding
        } else {
            modifited.right += padding
        }
        
        self.inset = modifited
    }
    
    override func setup() {
        super.setup()
        
        // add the image view and it's separator
        unitLabel.font = .font(for: .medium, size: 15)
        unitLabel.textColor = DefaultColorsProvider.secondaryText
        unitLabel.translatesAutoresizingMaskIntoConstraints = false
        unitLabel.text = "JD" // for arbitary reasons
        
        addSubview(unitLabel)
        unitLabel.centerVertically().trailing(15)

        self.updateInsets()
    }
}

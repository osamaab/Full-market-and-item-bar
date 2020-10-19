//
//  RoundedEdgesButton.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/6/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit

class RoundedEdgesButton: UIButton {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.layer.cornerRadius = self.frame.size.height / 2
    }

}

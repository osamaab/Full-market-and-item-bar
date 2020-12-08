//
//  BasicViewWithSetup.swift
//  talabyeh
//
//  Created by Hussein Work on 02/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

/**
 Just a view that provides the setup method, called after initialization,
 this makes it easy and convienience for subviews to setup content after initialization
 */
class BasicViewWithSetup: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){

    }
}

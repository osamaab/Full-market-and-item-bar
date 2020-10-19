//
//  RoundedEdgesView.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/6/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit

class RoundedEdgesView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.layer.cornerRadius = 10
    }
    

}

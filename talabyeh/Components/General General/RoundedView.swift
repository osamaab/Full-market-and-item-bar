//
//  RoundedEdgesView.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/6/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class RoundedView: UIView {
    
    /**
     While we don't use storyboards nor xib files, a backward compalibility needed.
     */
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        } get {
            return layer.cornerRadius
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        cornerRadius = 10
    }
}

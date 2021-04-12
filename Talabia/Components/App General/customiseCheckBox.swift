//
//  customiseCheckBox.swift
//  Talabia
//
//  Created by Osama Abu hdba on 06/04/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit

class CustomiseCheckboxView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        let radius = self.frame.width/2.0
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = false
    }
    override func layoutSubviews() {
            super.layoutSubviews()

            assert(bounds.height == bounds.width, "The aspect ratio isn't 1/1. You can never round this image view!")

            layer.cornerRadius = bounds.height / 2
        }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var isSelected: Bool = false {
        didSet {
            
            image = isSelected ? UIImage(named: "checkbox_selected") : UIImage(named: "not_selected")
            clipsToBounds = true
            let radius = self.frame.width/2.0
                self.layer.cornerRadius = radius
                self.layer.masksToBounds = true
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        image = isSelected ? UIImage(named: "checkbox_selected") : UIImage(named: "not_selected")
        clipsToBounds = true
        let radius = self.frame.width/2.0
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = true
    }
}

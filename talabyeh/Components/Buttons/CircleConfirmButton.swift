//
//  CircleConfirmButton.swift
//  talabyeh
//
//  Created by Hussein Work on 24/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class CircleConfirmButton: UIButton {
    
    override var isEnabled: Bool {
        didSet {
            setImage(isSelected ? UIImage(named: "card-submit-selected") : UIImage(named: "card-submit"), for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        isEnabled = false
    }
    
    override var intrinsicContentSize: CGSize {
        .init(width: 44, height: 44)
    }
}

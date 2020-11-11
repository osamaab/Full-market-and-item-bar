//
//  NibInstantiatable.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit

protocol NibInstantiatable {
    
    // returns the nib
    static func nib() -> UINib
    
    // creates an object from nib
    static func loadFromNib() -> Self?
}

extension NibInstantiatable where Self: UIView {
    static func loadFromNib() -> Self? {
        return Bundle.main.loadNibNamed(identifier, owner: nil, options: nil)?.first as? Self
    }
}

extension UIView: NibInstantiatable {
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

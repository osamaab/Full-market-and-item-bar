//
//  UIView+Additions.swift
//  talabyeh
//
//  Created by Hussein Work on 11/10/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit
import LanguageManager_iOS

extension UIView {
    internal func loadViewFromNib(viewClass: Swift.AnyClass) -> UIView! {
        let bundle = Bundle(for: viewClass.self)
        let nib = UINib(nibName: String(describing: viewClass.self), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.semanticContentAttribute = LanguageManager.shared.currentLanguage == .en ? .forceLeftToRight : .forceRightToLeft
        return view
    }
}

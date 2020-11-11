//
//  UIViewController+Traits.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit
import LanguageManager_iOS

extension NSObject {
    
    var currentLanguage: Languages {
        LanguageManager.shared.currentLanguage
    }
    
    var isRTL: Bool {
        LanguageManager.shared.isRightToLeft
    }
    
    var isLight: Bool {
        if #available(iOS 13.0, *) {
            return UITraitCollection.current.userInterfaceStyle == .light
        } else {
            return true
        }
    }
}

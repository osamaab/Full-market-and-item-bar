//
//  ColorsProviderType.swift
//  talabyeh
//
//  Created by Hussein Work on 03/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit.UIColor


let DefaultColorsProvider: ColorsProviderType.Type = AdaptiveColorsProvider.self

protocol ColorsProviderType {
    static var textPrimary1: UIColor { get }
    static var textPrimary2: UIColor { get }
    
    static var textSecondary1: UIColor { get }
    static var textSecondary2: UIColor { get }
    static var textSecondary3: UIColor { get }
    
    static var textPlaceholder: UIColor { get }
    
    static var elementUnselected: UIColor { get }
    static var elementBarBackground: UIColor { get }
    static var elementBarTint: UIColor { get }
    
    static var decoratorBorder: UIColor { get }
    static var decoratorShadow: UIColor { get }
    
    static var containerBackground1: UIColor { get }
    static var containerBackground2: UIColor { get }
    static var containerBackground3: UIColor { get }
    static var containerBackground4: UIColor { get }
    static var containerBackground5: UIColor { get }
    
    static var tintPrimary: UIColor { get }
    static var tintSecondary: UIColor { get }
    
    static var backgroundPrimary: UIColor { get }
    static var backgroundSecondary: UIColor { get }
    
    static var messageSuccess: UIColor { get }
    static var messageError: UIColor { get }
    static var messageNotice: UIColor { get }
    static var messageRating: UIColor { get }
}

extension UIColor {
    
    static var colorsProviderType: ColorsProviderType = AdaptiveColorsProvider()
    
    convenience init(lightColor: UIColor, darkColor: UIColor){
        self.init { (traitCollection) -> UIColor in
            switch traitCollection.userInterfaceStyle {
            case .light, .unspecified:
                return lightColor
            case .dark:
                return darkColor
            @unknown default:
                return lightColor
            }
        }
    }
}

//
//  AdaptiveColorsProvider.swift
//  talabyeh
//
//  Created by Hussein Work on 03/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit

struct AdaptiveColorsProvider: ColorsProviderType {
    
    static var lightSchemeProvider: ColorsProviderType.Type = LightSchemeColorProvider.self
    static var darkSchemeProvider: ColorsProviderType.Type = DarkSchemeColorProvider.self
    
    static var textPrimary1: UIColor {
        UIColor(lightColor: lightSchemeProvider.textPrimary1, darkColor: darkSchemeProvider.textPrimary1)
    }
    
    static var textPrimary2: UIColor {
        UIColor(lightColor: lightSchemeProvider.textPrimary2, darkColor: darkSchemeProvider.textPrimary2)
    }
    
    static var textSecondary1: UIColor {
        UIColor(lightColor: lightSchemeProvider.textSecondary1, darkColor: darkSchemeProvider.textSecondary1)
    }
    
    static var textSecondary2: UIColor {
        UIColor(lightColor: lightSchemeProvider.textSecondary2, darkColor: darkSchemeProvider.textSecondary2)
    }
    
    static var textSecondary3: UIColor {
        UIColor(lightColor: lightSchemeProvider.textSecondary3, darkColor: darkSchemeProvider.textSecondary3)
    }
    
    static var textPlaceholder: UIColor {
        UIColor(lightColor: lightSchemeProvider.textPlaceholder, darkColor: darkSchemeProvider.textPlaceholder)
    }
    
    static var elementUnselected: UIColor {
        UIColor(lightColor: lightSchemeProvider.elementUnselected, darkColor: darkSchemeProvider.elementUnselected)
    }
    
    static var elementBarBackground: UIColor {
        UIColor(lightColor: lightSchemeProvider.elementBarBackground, darkColor: darkSchemeProvider.elementBarBackground)
    }
    
    static var elementBarTint: UIColor {
        UIColor(lightColor: lightSchemeProvider.elementBarTint, darkColor: darkSchemeProvider.elementBarTint)
    }
    
    static var decoratorBorder: UIColor {
        UIColor(lightColor: lightSchemeProvider.decoratorBorder, darkColor: darkSchemeProvider.decoratorBorder)
    }
    
    static var decoratorShadow: UIColor {
        UIColor(lightColor: lightSchemeProvider.decoratorShadow, darkColor: darkSchemeProvider.decoratorShadow)
    }
    
    static var containerBackground1: UIColor {
        UIColor(lightColor: lightSchemeProvider.containerBackground1, darkColor: darkSchemeProvider.containerBackground1)
    }
    
    static var containerBackground2: UIColor {
        UIColor(lightColor: lightSchemeProvider.containerBackground2, darkColor: darkSchemeProvider.containerBackground2)
    }
    
    static var containerBackground3: UIColor {
        UIColor(lightColor: lightSchemeProvider.containerBackground3, darkColor: darkSchemeProvider.containerBackground3)
    }
    
    static var containerBackground4: UIColor {
        UIColor(lightColor: lightSchemeProvider.containerBackground4, darkColor: darkSchemeProvider.containerBackground4)
    }
    
    static var containerBackground5: UIColor {
        UIColor(lightColor: lightSchemeProvider.containerBackground5, darkColor: darkSchemeProvider.containerBackground5)
    }
    
    static var tintPrimary: UIColor {
        UIColor(lightColor: lightSchemeProvider.tintPrimary, darkColor: darkSchemeProvider.tintPrimary)
    }
    
    static var tintSecondary: UIColor {
        UIColor(lightColor: lightSchemeProvider.tintSecondary, darkColor: darkSchemeProvider.tintSecondary)
    }
    
    static var backgroundPrimary: UIColor {
        UIColor(lightColor: lightSchemeProvider.backgroundPrimary, darkColor: darkSchemeProvider.backgroundPrimary)
    }
    
    static var backgroundSecondary: UIColor {
        UIColor(lightColor: lightSchemeProvider.backgroundSecondary, darkColor: darkSchemeProvider.backgroundSecondary)
    }
    
    static var messageSuccess: UIColor {
        UIColor(lightColor: lightSchemeProvider.messageSuccess, darkColor: darkSchemeProvider.messageSuccess)
    }
    
    static var messageError: UIColor {
        UIColor(lightColor: lightSchemeProvider.messageError, darkColor: darkSchemeProvider.messageError)
    }
    
    static var messageNotice: UIColor {
        UIColor(lightColor: lightSchemeProvider.messageNotice, darkColor: darkSchemeProvider.messageNotice)
    }
    
    static var messageRating: UIColor {
        UIColor(lightColor: lightSchemeProvider.messageRating, darkColor: darkSchemeProvider.messageRating)
    }
}

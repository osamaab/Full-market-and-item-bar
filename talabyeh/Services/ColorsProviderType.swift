//
//  ColorsProvider.swift
//  talabyeh
//
//  Created by Hussein Work on 11/10/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit.UIColor

enum ColorGroup: String, CaseIterable {
    case text
    case element
    case decorator
    case container
    case tint
    case background
    case message
    case uncategorized
}

let DefaultColorsProvider: ColorsProviderType = {
    LightSchemeColorProvider()
//    let style = AppDelegate.shared.window?.traitCollection.userInterfaceStyle ?? .light
//    return style == .dark ? DarkSchemeColorProvider() : LightSchemeColorProvider()
}()



protocol ColorsProviderType {
    var textPrimary1: UIColor { get }
    var textPrimary2: UIColor { get }
    
    var textSecondary1: UIColor { get }
    var textSecondary2: UIColor { get }
    var textSecondary3: UIColor { get }
    
    var textPlaceholder: UIColor { get }
    
    var elementUnselected: UIColor { get }
    var elementBarBackground: UIColor { get }
    var elementBarTint: UIColor { get }
    
    var decoratorBorder: UIColor { get }
    var decoratorShadow: UIColor { get }
    
    var containerBackground1: UIColor { get }
    var containerBackground2: UIColor { get }
    var containerBackground3: UIColor { get }
    var containerBackground4: UIColor { get }
    var containerBackground5: UIColor { get }
    
    var tintPrimary: UIColor { get }
    var tintSecondary: UIColor { get }
    
    var backgroundPrimary: UIColor { get }
    var backgroundSecondary: UIColor { get }
    
    var messageSuccess: UIColor { get }
    var messageError: UIColor { get }
    var messageNotice: UIColor { get }
    var messageRating: UIColor { get }
}


struct LightSchemeColorProvider: ColorsProviderType {
    let textPrimary1 = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) // 000000
    let textPrimary2 = #colorLiteral(red: 0.1529411765, green: 0.1647058824, blue: 0.2470588235, alpha: 1) // 272A3F
    
    let textSecondary1 = #colorLiteral(red: 0.4980392157, green: 0.5647058824, blue: 0.5098039216, alpha: 1) // 7F9082
    let textSecondary2 = #colorLiteral(red: 0.431372549, green: 0.4745098039, blue: 0.5411764706, alpha: 1) // 6E798A
    let textSecondary3 = #colorLiteral(red: 0.6039215686, green: 0.631372549, blue: 0.6941176471, alpha: 1) // 9AA1B1
    
    let textPlaceholder = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1) // A0A7B7
    
    let elementUnselected = #colorLiteral(red: 0.431372549, green: 0.4745098039, blue: 0.5411764706, alpha: 1) // 6E798A
    let elementBarBackground = #colorLiteral(red: 0.06666666667, green: 0.3607843137, blue: 0.1960784314, alpha: 1) // 115C32
    let elementBarTint = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) // FFFFFF
    
    let decoratorBorder = #colorLiteral(red: 0.831372549, green: 0.831372549, blue: 0.8784313725, alpha: 1) // 707070
    let decoratorShadow = #colorLiteral(red: 0.831372549, green: 0.831372549, blue: 0.8784313725, alpha: 1) // 707070
    
    let containerBackground1 = #colorLiteral(red: 0.6039215686, green: 0.631372549, blue: 0.6941176471, alpha: 1) // 9AA1B1
    let containerBackground2 = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1) // CCCCCC
    let containerBackground3 = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1) // F2F2F2
    let containerBackground4 = #colorLiteral(red: 0.431372549, green: 0.4745098039, blue: 0.5411764706, alpha: 1) // 6E798A
    let containerBackground5 = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1) // 707070
    
    let tintPrimary = #colorLiteral(red: 0.06666666667, green: 0.3607843137, blue: 0.1960784314, alpha: 1) // 115C32
    let tintSecondary = #colorLiteral(red: 0.7411764706, green: 0.937254902, blue: 0.2078431373, alpha: 1) // BDEF35
    
    let backgroundPrimary = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) // FFFFFF
    let backgroundSecondary = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1) // F2F2F2
    
    let messageSuccess = #colorLiteral(red: 0, green: 0.7843137255, blue: 0.5490196078, alpha: 1) // 00C88C
    let messageError = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) // FF0000
    let messageNotice = #colorLiteral(red: 0.7843137255, green: 0.7529411765, blue: 0, alpha: 1) // C8C000
    let messageRating = #colorLiteral(red: 1, green: 0.5019607843, blue: 0.3921568627, alpha: 1) // FF8064
}

struct DarkSchemeColorProvider: ColorsProviderType {
    
    let textPrimary1 = UIColor.label
    let textPrimary2 = UIColor.label
    
    let textSecondary1 = UIColor.secondaryLabel
    let textSecondary2 = UIColor.secondaryLabel
    let textSecondary3 = UIColor.secondaryLabel
    
    let textPlaceholder = UIColor.placeholderText
    
    let elementUnselected = UIColor.systemGray2
    let elementBarBackground = UIColor.systemBackground
    let elementBarTint = #colorLiteral(red: 0.7411764706, green: 0.937254902, blue: 0.2078431373, alpha: 1)
    
    let decoratorBorder = UIColor.separator
    let decoratorShadow = UIColor.systemGray2
    
    let containerBackground1 = UIColor.systemGroupedBackground
    let containerBackground2 = UIColor.systemGroupedBackground
    let containerBackground3 = UIColor.systemGroupedBackground
    let containerBackground4 = UIColor.systemGroupedBackground
    let containerBackground5 = UIColor.systemGroupedBackground
    
    let tintPrimary = #colorLiteral(red: 0.7411764706, green: 0.937254902, blue: 0.2078431373, alpha: 1)
    let tintSecondary = #colorLiteral(red: 0.06666666667, green: 0.3607843137, blue: 0.1960784314, alpha: 1)
    
    let backgroundPrimary = UIColor.systemBackground
    let backgroundSecondary = UIColor.secondarySystemBackground
    
    let messageSuccess = #colorLiteral(red: 0, green: 0.7843137255, blue: 0.5490196078, alpha: 1)
    let messageError = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
    let messageNotice = #colorLiteral(red: 0.7843137255, green: 0.7529411765, blue: 0, alpha: 1)
    let messageRating = #colorLiteral(red: 1, green: 0.5019607843, blue: 0.3921568627, alpha: 1)
}

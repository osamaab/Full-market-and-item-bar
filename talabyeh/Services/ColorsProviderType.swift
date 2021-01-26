//
//  ColorsProvider.swift
//  talabyeh
//
//  Created by Hussein Work on 11/10/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit.UIColor

typealias DefaultColorsProvider = DarkSchemeColorProvider

struct LightSchemeColorProvider {
    
    // texts and elements
    static let text = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) // 000000
    static let text2 = #colorLiteral(red: 0.1529411765, green: 0.1647058824, blue: 0.2470588235, alpha: 1) // 272A3F
    
    static let secondaryText = #colorLiteral(red: 0.4980392157, green: 0.5647058824, blue: 0.5098039216, alpha: 1) // 7F9082
    static let secondaryText1 = #colorLiteral(red: 0.431372549, green: 0.4745098039, blue: 0.5411764706, alpha: 1) // 6E798A
    static let secondaryText2 = #colorLiteral(red: 0.6039215686, green: 0.631372549, blue: 0.6941176471, alpha: 1) // 9AA1B1
    
    static let placeholder = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1) // A0A7B7
    
    // elements
    static let tabbarUnselected = #colorLiteral(red: 0.431372549, green: 0.4745098039, blue: 0.5411764706, alpha: 1) // 6E798A
    static let navigationBar = darkerTint
    static let navigationBarElements = background
    
    // borders and separators
    static let fieldBorder = #colorLiteral(red: 0.831372549, green: 0.831372549, blue: 0.8784313725, alpha: 1) // 707070
    static let baseShadow = UIColor.lightGray
    
    // element backgrounds
    static let pickerBackground = #colorLiteral(red: 0.6039215686, green: 0.631372549, blue: 0.6941176471, alpha: 1) // 9AA1B1
    static let darkerItemBackground = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1) // CCCCCC
    static let itemBackground = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1) // F2F2F2
    static let itemBackground2 = #colorLiteral(red: 0.431372549, green: 0.4745098039, blue: 0.5411764706, alpha: 1) // 6E798A
    static let itemBackground3 = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1) // 707070
    
    // tints
    static let darkerTint = #colorLiteral(red: 0.06666666667, green: 0.3607843137, blue: 0.1960784314, alpha: 1) // 115C32
    static let lightTint = #colorLiteral(red: 0.7411764706, green: 0.937254902, blue: 0.2078431373, alpha: 1) // BDEF35
    
    // backgrounds
    static let background = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) // FFFFFF
    static let background1 = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1) // F2F2F2
    
    // messages
    static let success = #colorLiteral(red: 0, green: 0.7843137255, blue: 0.5490196078, alpha: 1) // 00C88C
    static let error = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) // FF0000
    static let notice = #colorLiteral(red: 0.7843137255, green: 0.7529411765, blue: 0, alpha: 1) // C8C000
    static let rating = #colorLiteral(red: 1, green: 0.5019607843, blue: 0.3921568627, alpha: 1) // FF8064
}

struct DarkSchemeColorProvider {
    
    // texts and elements
    static let text = UIColor.label
    static let text2 = UIColor.label
    
    static let secondaryText = UIColor.secondaryLabel
    static let secondaryText1 = UIColor.secondaryLabel
    static let secondaryText2 = UIColor.secondaryLabel
    
    static let placeholder = UIColor.placeholderText
    
    // elements
    static let tabbarUnselected = UIColor.systemGray2
    static let navigationBar = UIColor.systemBackground
    static let navigationBarElements = darkerTint
    
    // borders and separators
    static let fieldBorder = UIColor.separator
    static let baseShadow = UIColor.systemGray2
    
    // element backgrounds
    static let pickerBackground = UIColor.systemGroupedBackground
    static let darkerItemBackground = UIColor.systemGroupedBackground
    static let itemBackground = UIColor.systemGroupedBackground
    static let itemBackground2 = UIColor.systemGroupedBackground
    static let itemBackground3 = UIColor.systemGroupedBackground
    
    // tints
    static let darkerTint = #colorLiteral(red: 0.7411764706, green: 0.937254902, blue: 0.2078431373, alpha: 1)
    static let lightTint = #colorLiteral(red: 0.06666666667, green: 0.3607843137, blue: 0.1960784314, alpha: 1)
    
    // backgrounds
    static let background = UIColor.systemBackground
    static let background1 = UIColor.secondarySystemBackground
    
    // messages
    static let success = #colorLiteral(red: 0, green: 0.7843137255, blue: 0.5490196078, alpha: 1) // 00C88C
    static let error = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) // FF0000
    static let notice = #colorLiteral(red: 0.7843137255, green: 0.7529411765, blue: 0, alpha: 1) // C8C000
    static let rating = #colorLiteral(red: 1, green: 0.5019607843, blue: 0.3921568627, alpha: 1) // FF8064
}

//
//  ColorsProvider.swift
//  talabyeh
//
//  Created by Hussein Work on 11/10/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit.UIColor

struct DefaultColorsProvider {
    
    /**
     The choice of the message colors still generic somehow, but they are very essential
     */
    static let success = UIColor(rgb: 0x52D67D)
    static let error = UIColor(rgb: 0xE70C0A)
    static let notice = UIColor(rgb: 0xFFBA00)

    static let lightTint = UIColor(rgb: 0xBDEF35)
    static let darkTint = UIColor(rgb: 0x115C32)
    
    //TODO: Add more colors
    
    static var background: UIColor {
        if #available(iOS 13.0, *) {
            return .systemBackground
        } else {
            return UIColor.white
        }
    }
}


//MARK: Backward Compilability
enum AdaptiveColors: String{
    case black = "Black Adaptive"
    case green = "Green Adaptive"
    case lightGrey = "Light Grey Adaptive"
    case white = "White Adaptive"
    case buttonGrey = "Button Grey Background Adaptive"
    case textGrey = "Text Grey Adaptive"
    case darkGrey = "Dark Grey Adaptive"
}

class Constants{

    static let baseURL = "http://www.talabyeh.com/api/"
    
    static let darkGreen = #colorLiteral(red: 0.06666666667, green: 0.3607843137, blue: 0.1960784314, alpha: 1) //#115C32
    static let lightGreen = #colorLiteral(red: 0.7411764706, green: 0.937254902, blue: 0.2078431373, alpha: 1) //BDEF35
    static let buttonGreyBackground = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1) //CCCCCC
    static let lightGrey = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1) //F2F2F2
    static let darkGrey = #colorLiteral(red: 0.6039215686, green: 0.631372549, blue: 0.6941176471, alpha: 1) //9AA1B1
    static let borderGrey = #colorLiteral(red: 0.6862745098, green: 0.6862745098, blue: 0.6862745098, alpha: 1) //AFAFAF
    static let textGrey = #colorLiteral(red: 0.4980392157, green: 0.5647058824, blue: 0.5098039216, alpha: 1) //#7F9082
    static let blackText = #colorLiteral(red: 0.1529411765, green: 0.1647058824, blue: 0.2470588235, alpha: 1)//#272A3F
    static let whiteText = #colorLiteral(red: 0.9529411765, green: 0.9568627451, blue: 0.9607843137, alpha: 1) // #F3F4F5
}


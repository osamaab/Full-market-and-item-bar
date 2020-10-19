//
//  Constants.swift
//  
//
//  Created by Loai Elayan on 10/7/20.
//

import Foundation
import UIKit

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
}


extension NSObject{
    
    enum fontTypeEnglish:String {
        case ultraLight = "SFUIDisplay-Ultralight"
        case light = "SFUIDisplay-Light"
        case thin = "SFUIDisplay-Thin"
        case medium = "SFUIDisplay-Medium"
        case semiBold = "SFUIDisplay-Semibold"
        case bold = "SFUIDisplay-Bold"
        case heavy = "SFUIDisplay-Heavy"

    }
    
    enum fontTypeArabic:String {
        case ultraLight = "DINNextLTW23-UltraLight"
        case light = "DINNextLTW23-Light"
        case regular = "DINNextLTW23-Regular"
        case bold = "DINNextLTW23-Bold"
        case heavy = "DINNextLTW23-Heavy"
        case black = "DINNextLTW23-Black"
    }
    
    final func getEnglishFont(_ size:CGFloat,_ fontType:fontTypeEnglish) -> UIFont{
        if let font =  UIFont(name: fontType.rawValue, size: size) {
            return font
        }
        else{
            return UIFont.boldSystemFont(ofSize: size)
        }
    }
    
    final func getArabicFont(_ size:CGFloat,_ fontType:fontTypeArabic) -> UIFont{
        if let font =  UIFont(name: fontType.rawValue, size: size) {
            return font
        }
        else{
            return UIFont.boldSystemFont(ofSize: size)
        }
    }
}

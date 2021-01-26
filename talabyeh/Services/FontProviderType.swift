//
//  FontProviderType.swift
//  talabyeh
//
//  Created by Hussein Work on 11/10/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit.UIFont
import LanguageManager_iOS

enum FontTrait: String {
    case extraLight
    case light
    case regular
    case medium
    case semiBold
    case bold
    case black
    case heavy
}

/**
 A font provider provides a font for given trait and size.
 */
protocol FontProviderType {
    func font(for trait: FontTrait, size: CGFloat) -> UIFont
}


struct EnglishFontProvider: FontProviderType {
    func name(for trait: FontTrait) -> String {
        switch trait {
        case .extraLight:
            return "Ultralight"
        case .light:
            return "Light"
        case .regular:
            return "Medium" // still don't know why the reuglar font isn't provided, but we're dealing with generic traits, so providing a regular font for regular trait is a must
        case .medium:
            return "Medium"
        case .semiBold:
            return "Semibold"
        case .bold:
            return "Bold"
        case .black:
            return "Black"
        case .heavy:
            return "Heavy"
        }
    }
    
    func font(for trait: FontTrait, size: CGFloat) -> UIFont {
        let fontName = "SFUIDisplay-\(name(for: trait))"
        return UIFont(name: fontName, size: size)!
    }
}


struct ArabicFontProvider: FontProviderType {
    func name(for trait: FontTrait) -> String {        
        switch trait {
        case .extraLight:
            return "UltraLight"
        case .light:
            return "Light"
        case .regular:
            return "Regular"
        case .medium:
            return "Regular"
        case .semiBold:
            return "Bold"
        case .bold:
            return "Bold"
        case .black:
            return "Black"
        case .heavy:
            return "Heavy"
        }
    }
    
    func font(for trait: FontTrait, size: CGFloat) -> UIFont {
        let fontName = "DINNextLTW23-\(name(for: trait))"
        return UIFont(name: fontName, size: size)!
    }
}


/**
 A class that automaticly chooses the type of font depending on the language
 */
struct DefaultFontProvider: FontProviderType {
    
    static let dynamic: DefaultFontProvider = .init()
    
    var isLanguageArabic: Bool {
        LanguageManager.shared.isRightToLeft
    }
    
    func font(for trait: FontTrait, size: CGFloat) -> UIFont {
        if isLanguageArabic {
            return ArabicFontProvider().font(for: trait, size: size)
        } else {
            return EnglishFontProvider().font(for: trait, size: size)
        }
    }
}

extension UIFont {
    static func font(for trait: FontTrait, size: CGFloat) -> UIFont {
        DefaultFontProvider.dynamic.font(for: trait, size: size)
    }
}

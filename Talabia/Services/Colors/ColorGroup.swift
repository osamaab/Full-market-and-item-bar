//
//  ColorGroup.swift
//  talabyeh
//
//  Created by Hussein Work on 03/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

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

enum ColorIdentifier: String, CaseIterable {
    case textPrimary1
    case textPrimary2
    
    case textSecondary1
    case textSecondary2
    case textSecondary3
    
    case textPlaceholder
    
    case elementUnselected
    case elementBarBackground
    case elementBarTint
    
    case decoratorBorder
    case decoratorShadow
    
    case containerBackground1
    case containerBackground2
    case containerBackground3
    case containerBackground4
    case containerBackground5
    
    case tintPrimary
    case tintSecondary
    
    case backgroundPrimary
    case backgroundSecondary
    
    case messageSuccess
    case messageError
    case messageNotice
    case messageRating
}


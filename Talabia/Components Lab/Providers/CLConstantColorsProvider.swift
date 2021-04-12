//
//  CLConstantColorsProvider.swift
//  talabyeh
//
//  Created by Hussein Work on 25/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit


struct CLConstantColorsProvider: CLColorsSectionListProvider {
    func sections() -> [CLColorsSection] {
        
        // we use enumeration to get all color groups + all colors avaiable.
        let groups = ColorGroup.allCases
        var groupedColors: [ColorGroup: [CLColorItem]] = [:]
        
        let colorsMirror = Mirror(reflecting: LightSchemeColorProvider())
        for child in colorsMirror.children {
            if let color = child.value as? UIColor, let label = child.label {
                let camelCasedWord = label.camelCaseToWords()
                let leadingName = label.camelCaseToWords().components(separatedBy: CharacterSet.whitespaces)[0]

                let finalName = camelCasedWord.replacingOccurrences(of: leadingName + " ", with: "")
                
                // convert it to color item
                let item = CLColorItem(color: color, name: finalName)
                
                
                
                // now, get the first group matches it's name
                let matchedGroup = groups.first { $0.rawValue == leadingName } ?? .uncategorized
                
                if let currentValue = groupedColors[matchedGroup] {
                    groupedColors[matchedGroup] = currentValue + [item]
                } else {
                    groupedColors[matchedGroup] = [item]
                }
            }
        }
        
        return groupedColors.map {
            CLColorsSection(name: $0.key.rawValue.capitalizingFirstLetter(), items: $0.value)
        }
    }
}

//
//  CLComponentsRegisterationSectionListProvider.swift
//  talabyeh
//
//  Created by Hussein Work on 24/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import Foundation


struct CLComponentsRegisterationSectionListProvider {
    
    
    
    
}

extension CLComponentsRegisterationSectionListProvider: CLComponentSectionListProvider {
    func sections() -> [CLComponentsSection] {
        let screensMirror = Mirror(reflecting: self)
        
        
        var screenSections: [CLComponentsSection] = []
        for element in screensMirror.children {
            if let screenSection = element.value as? CLComponentsSection {
                screenSections.append(screenSection)
            }
        }
        
        return screenSections
    }
}


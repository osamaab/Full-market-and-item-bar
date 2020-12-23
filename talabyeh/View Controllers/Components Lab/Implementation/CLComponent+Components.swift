//
//  CLComponent+Components.swift
//  talabyeh
//
//  Created by Hussein Work on 18/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import Foundation

struct CLComponentDefaultRegisteration {
    let buttons: CLComponentsSection = {
        let components: [CLAnyComponentItem] = [
        
        ]
        
        return CLComponentsSection(name: "Buttons", items: components)
    }()
}

extension CLComponentsSection {

}

//            CLAnyItem(name: "Buttons"),
//            CLAnyItem(name: "Shared Cells"),
//            CLAnyItem(name: "Headers and Footers"),
//            CLAnyItem(name: "General General"),
//            CLAnyItem(name: "App General"),
//            CLAnyItem(name: "Buttons"),
//            CLAnyItem(name: "Text Fields"),
//            CLAnyItem(name: "Pickers")

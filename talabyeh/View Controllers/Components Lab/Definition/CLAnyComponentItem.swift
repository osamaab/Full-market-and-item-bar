//
//  CLAnyComponentItem.swift
//  talabyeh
//
//  Created by Hussein Work on 18/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

struct CLAnyComponentItem: CLComponentItem {
    typealias ComponentViewFactory = (() -> UIView)    
    /**
     A custom identifier to identify the component
     */
    let id: String = UUID().uuidString
    
    /**
     The name of the component
     */
    let name: String
    
    /**
     Custom Attributes for after generating the component
     */
    let attributes: [CLComponentAttribute]
    
    /**
     Clousure for generating the component
     */
    let factory: ComponentViewFactory
        
    
    init(name: String, attributes: [CLComponentAttribute], factory: @escaping ComponentViewFactory){
        self.name = name
        self.attributes = attributes
        self.factory = factory
    }
    
    /**
     generates the compnoent view
     */
    func generateComponentView() -> UIView {
        self.factory()
    }
}

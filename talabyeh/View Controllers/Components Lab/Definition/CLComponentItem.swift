//
//  CLComponentItem.swift
//  talabyeh
//
//  Created by Hussein Work on 18/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

protocol CLComponentItem {
    typealias ComponentViewFactory = (() -> UIView)

    /**
     A custom identifier to identify the component
     */
    var id: String { get }
    
    /**
     The name of the component
     */
    var name: String { get }
    
    /**
     Custom Attributes for after generating the component
     */
    var attributes: [CLComponentAttribute] { get }
    
    /**
     generates the compnoent view
     */
    func generateComponentView() -> UIView
}





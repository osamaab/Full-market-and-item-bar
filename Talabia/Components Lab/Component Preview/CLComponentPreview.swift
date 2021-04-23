//
//  CLComponentPreview.swift
//  talabyeh
//
//  Created by Hussein Work on 24/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import Foundation



protocol CLComponentPreview {
    
    /**
     The name of the component, default to be the class name - Any Additions, like View, ContentView, Name, and others.
     */
    static var name: String { get }
    
    /**
     The group for the component, for better separating
     */
    static var groupIdentifier: CLComponentGroupIdentifier { get }
    
    /**
     Tells the receiver to render a sample of itself into the given context, the context will then will be used to show the preview of the given view.
     */
    static func render(in context: CLComponentPreviewContext)
}

extension CLComponentPreview {
    static var name: String {
        let name = String(describing: self).camelCaseToWords()
        return name.replacingOccurrences(of: "Button", with: "")
    }
}

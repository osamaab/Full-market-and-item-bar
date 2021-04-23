//
//  ParametersConvertable.swift
//  talabyeh
//
//  Created by Hussein Work on 06/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

public protocol ParametersConvertable {
    var parameters: [String: Any] { get }
}

public extension ParametersConvertable {
    private subscript(checkedMirrorDescendant key: String) -> Any {
        return Mirror(reflecting: self).descendant(key)!
    }
    
    var allKeyPaths: [String: PartialKeyPath<Self>] {
        var membersTokeyPaths = [String: PartialKeyPath<Self>]()
        let mirror = Mirror(reflecting: self)
        for case (let key?, _) in mirror.children {
            membersTokeyPaths[key] = \Self.[checkedMirrorDescendant: key] as PartialKeyPath
        }
        return membersTokeyPaths
    }
    
    var parameters: [String: Any] {
        let reflection = Mirror(reflecting: self)

        let values = reflection.children
        var valuesArray = [String: Any]()
        for case let item in values where item.label != nil {
            if case Optional<Any>.some(let value) = item.value {
                valuesArray[item.label!] = value
            }
        }

        return valuesArray
    }
}

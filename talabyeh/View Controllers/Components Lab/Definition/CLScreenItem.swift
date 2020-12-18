//
//  CLAnyScreenItem.swift
//  talabyeh
//
//  Created by Hussein Work on 18/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import Foundation
import UIKit

struct CLScreenItem: Hashable, Equatable {
    typealias CreateHandler = (() -> UIViewController)
    
    static func == (lhs: CLScreenItem, rhs: CLScreenItem) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: String = UUID().uuidString
    
    let name: String
    let path: String?
   
    let screenClass: UIViewController.Type?
    let createHandler: CreateHandler?

    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func getScreen() -> UIViewController? {
        if let handler = self.createHandler {
            return handler()
        }
        
        if let screenClass = self.screenClass {
            return screenClass.init()
        }
        
        return nil
    }
    
    
    init(name: String, path: String? = nil, creationHandler: @escaping CreateHandler){
        self.name = name
        self.path = path
        self.createHandler = creationHandler
        self.screenClass = nil
    }
    
    init(name: String, path: String? = nil, screenClass: UIViewController.Type){
        self.name = name
        self.path = path
        self.screenClass = screenClass
        self.createHandler = nil
    }
    
    init(name: String, path: String? = nil){
        self.name = name
        self.path = path
        self.screenClass = nil
        self.createHandler = nil
    }
}

extension CLScreenItem {
    init(screenClass: UIViewController.Type){
        let name = String(describing: screenClass)
        let trailingsRemoved = name.replacingOccurrences(of: "ViewController", with: "")
        self.init(name: trailingsRemoved.camelCaseToWords(), screenClass: screenClass)
    }
}

extension String {
    func camelCaseToWords() -> String {
        return unicodeScalars.reduce("") {
            if CharacterSet.uppercaseLetters.contains($1) {
                return ($0 + " " + String($1))
            } else {
                return $0 + String($1)
            }
        }
    }
}

//
//  UserDefaults+Codable.swift
//  talabyeh
//
//  Created by Hussein Work on 17/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation


extension UserDefaults {
    func set<Element: Codable>(value: Element, forKey key: String) {
        
        do {
            let data = try JSONEncoder().encode(value)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Fail to set codable value for key \(key), error: \(error)")
        }
        
    }
    func codable<Element: Codable>(forKey key: String) -> Element? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        do {
            let element = try JSONDecoder().decode(Element.self, from: data)
            return element
        } catch {
            print("fail to retrive codable value for \(key), error: \(error)")
        }
        
        return nil
    }
}



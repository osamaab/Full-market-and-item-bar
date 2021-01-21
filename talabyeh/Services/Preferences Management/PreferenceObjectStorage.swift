//
//  PreferenceObjectStorage.swift
//  talabyeh
//
//  Created by Hussein Work on 19/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

@propertyWrapper
struct ObjectStorage<T: Codable> {
    private let key: PreferenceKey
    private let defaultValue: T
    private let storage = UserDefaults.standard


    init(key: PreferenceKey, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            // Read value from UserDefaults
            guard let data = UserDefaults.standard.object(forKey: key.rawValue) as? Data else {
                return defaultValue
            }

            // Convert data to the desire data type
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                storage.removeObject(forKey: key.rawValue)
            } else {
                // Convert newValue to data
                let data = try? JSONEncoder().encode(newValue)
                
                // Set value to UserDefaults
                UserDefaults.standard.set(data, forKey: key.rawValue)

            }
        }
    }
}

extension ObjectStorage where T: ExpressibleByNilLiteral {
    init(key: PreferenceKey) {
        self.init(key: key, defaultValue: nil)
    }
}



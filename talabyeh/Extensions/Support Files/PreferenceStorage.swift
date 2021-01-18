//
//  PreferenceStorage.swift
//  talabyeh
//
//  Created by Hussein Work on 17/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

@propertyWrapper
struct ObjectStorage<T: Codable> {
    private let key: String
    private let defaultValue: T
    private let storage = UserDefaults.standard


    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            // Read value from UserDefaults
            guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
                return defaultValue
            }

            // Convert data to the desire data type
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                storage.removeObject(forKey: key)
            } else {
                // Convert newValue to data
                let data = try? JSONEncoder().encode(newValue)
                
                // Set value to UserDefaults
                UserDefaults.standard.set(data, forKey: key)

            }
        }
    }
}

@propertyWrapper
struct PreferenceStorage<T> {
    private let key: String
    private let defaultValue: T
    private let storage = UserDefaults.standard

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            // Read value from UserDefaults
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                storage.removeObject(forKey: key)
            } else {
                storage.setValue(newValue, forKey: key)
            }
            // Set value to UserDefaults
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

extension ObjectStorage where T: ExpressibleByNilLiteral {
    init(key: String) {
        self.init(key: key, defaultValue: nil)
    }
}

extension PreferenceStorage where T: ExpressibleByNilLiteral {
    init(key: String) {
        self.init(key: key, defaultValue: nil)
    }
}

private protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    var isNil: Bool { self == nil }
}

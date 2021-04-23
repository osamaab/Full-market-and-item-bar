//
//  PreferenceStorage.swift
//  talabyeh
//
//  Created by Hussein Work on 19/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

@propertyWrapper
struct PreferenceStorage<T> {
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
            return UserDefaults.standard.object(forKey: key.rawValue) as? T ?? defaultValue
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                storage.removeObject(forKey: key.rawValue)
            } else {
                storage.setValue(newValue, forKey: key.rawValue)
            }
            // Set value to UserDefaults
            UserDefaults.standard.set(newValue, forKey: key.rawValue)
        }
    }
}

extension PreferenceStorage where T: ExpressibleByNilLiteral {
    init(key: PreferenceKey) {
        self.init(key: key, defaultValue: nil)
    }
}

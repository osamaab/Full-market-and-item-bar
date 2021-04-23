//
//  AppDelegate+Dependencies.swift
//  talabyeh
//
//  Created by Hussein Work on 02/03/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import Resolver
extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        Resolver.defaultScope = Resolver.application

        register {
            DefaultSetupSteps {
                DefaultSetupSteps.LanguageSetupStep()
                DefaultSetupSteps.KeyboardSetupStep()
                DefaultSetupSteps.ApperanceSetupStep()
            }
        }.implements(AppSetupStepType.self)
        
        register {
            DefaultCartManager()
        }.implements(CartManagerType.self)
        
        register {
            UserDefaultsPreferencesManager()
        }.implements(PreferencesManagerType.self)
    }
}



/// Immediate injection property wrapper.
///
/// Wrapped dependent service is resolved immediately using Resolver.root upon struct initialization.
///
@propertyWrapper
public struct Injected<Service> {
    private var service: Service
    public init() {
        self.service = Resolver.resolve(Service.self)
    }
//    public init(name: String? = nil, container: Resolver? = nil) {
//        
////        self.service = container?.resolve(Service.self, name: name ) ?? Resolver.resolve(Service.self, name: name)
//    }
    public var wrappedValue: Service {
        get { return service }
        mutating set { service = newValue }
    }
    public var projectedValue: Injected<Service> {
        get { return self }
        mutating set { self = newValue }
    }
}

/// Lazy injection property wrapper. Note that mbedded container and name properties will be used if set prior to service instantiation.
///
/// Wrapped dependent service is not resolved until service is accessed.
///
@propertyWrapper
public struct LazyInjected<Service> {
    private var service: Service!
    public var container: Resolver?
    public var name: String?
    public init() {}
    public init(name: String? = nil, container: Resolver? = nil) {
        self.name = name
        self.container = container
    }
    public var isEmpty: Bool {
        return service == nil
    }
    public var wrappedValue: Service {
        mutating get {
            if self.service == nil {
//                self.service = container?.resolve(Service.self, name: name) ?? Resolver.resolve(Service.self, name: name)
            }
            return service
        }
        mutating set { service = newValue  }
    }
    public var projectedValue: LazyInjected<Service> {
        get { return self }
        mutating set { self = newValue }
    }
    public mutating func release() {
        self.service = nil
    }
}

@propertyWrapper
public struct OptionalInjected<Service> {
    private var service: Service?
    public init() {
        self.service = Resolver.optional(Service.self)
    }
    public init(name: String? = nil, container: Resolver? = nil) {
//        self.service = container?.optional(Service.self, name: name) ?? Resolver.optional(Service.self, name: name)
    }
    public var wrappedValue: Service? {
        get { return service }
        mutating set { service = newValue }
    }
    public var projectedValue: OptionalInjected<Service> {
        get { return self }
        mutating set { self = newValue }
    }
}

//
//  DefaultAuthenticationManager.swift
//  talabyeh
//
//  Created by Hussein Work on 17/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

class DefaultAuthenticationManager: AuthenticationManagerType {
    
    private enum Keys: String, CaseIterable {
        case userType
        case authToken
        case profile
    }
    
    var isAuthenticated: Bool {
        authProfile != nil && authToken != nil
    }
    
    static var shared: DefaultAuthenticationManager = .init()
    
    fileprivate(set) var authProfile: AuthUserProfile?
    fileprivate(set) var userType: UserType?
    fileprivate(set) var authToken: String?
    
    
    /**
     The default initializer returns data from user defaults.
     */
    init(){
        let userTypeRaw = UserDefaults.standard.integer(forKey: Keys.userType.rawValue)
        guard let userType = UserType(rawValue: userTypeRaw) else {
            return
        }
        
        switch userType {
        case .company:
            if let company: Company = UserDefaults.standard.codable(forKey: Keys.profile.rawValue) {
                self.authProfile = .company(company)
            }
        case .distributor:
            if let distributor: Distributor = UserDefaults.standard.codable(forKey: Keys.profile.rawValue) {
                self.authProfile = .distributor(distributor)
            }
        case .reseller:
            if let reseller: Reseller = UserDefaults.standard.codable(forKey: Keys.profile.rawValue) {
                self.authProfile = .reseller(reseller)
            }
        }
        
        self.authToken = UserDefaults.standard.string(forKey: Keys.authToken.rawValue)
    }
    
    func login(with profile: AuthUserProfile) {
        self.authProfile = profile
        
        switch profile {
        case .company(let company):
            self.userType = .company
            self.authToken = company.user.token
            
            
            // write down to user defaults
            UserDefaults.standard.set(value: company, forKey: Keys.profile.rawValue)
            break
        case .distributor(let distributor):
            self.userType = .distributor
            self.authToken = ""//distributor.user.token
            
            UserDefaults.standard.set(value: distributor, forKey: Keys.profile.rawValue)
            break
        case .reseller(let reseller):
            self.userType = .reseller
            self.authToken = reseller.user.token
            
            UserDefaults.standard.set(value: reseller, forKey: Keys.profile.rawValue)
            break
        }
        
        
        
        UserDefaults.standard.set(authToken!, forKey: Keys.authToken.rawValue)
        UserDefaults.standard.set(userType!.rawValue, forKey: Keys.userType.rawValue)
    }
    
    func logout() {
        Keys.allCases.forEach {
            UserDefaults.standard.removeObject(forKey: $0.rawValue)
        }
    }
}

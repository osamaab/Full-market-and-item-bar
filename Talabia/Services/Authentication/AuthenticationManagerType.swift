//
//  AuthenticationManagerType.swift
//  talabyeh
//
//  Created by Hussein Work on 17/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation



protocol AuthenticationManagerType: class {
    
    /**
     Tells if the user is authenticated or not.
     */
    var isAuthenticated: Bool { get }
    
    /**
     The Currennt profile for the auth type.
     */
    var authProfile: AuthUserProfile? { get }
    
    
    /**
     The authenticated user type if available.
     */
    var userType: UserType? { get }
 
    
    /**
     Used for authenticating the requests in APIs
     */
    var authToken: String? { get }
    
    /**
     Performs a login with given profile type
     */
    func login(with profile: AuthUserProfile)
    
    /**
     Removes any credentials for the current user.
     */
    func logout()
}




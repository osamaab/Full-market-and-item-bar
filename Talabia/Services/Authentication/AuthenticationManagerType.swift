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
    
    
    /**
     A client can trigger a specific action to be performed only the user is authenticated, a typical scenario would be:
     - If the user is already authenticated, then perform the block
     - If not, then present the authentication coordinator ( sign in or signup ), with it's completion to be the given block
     */
    func performIfAuthenticated(_ block: @escaping (() -> Void))
}




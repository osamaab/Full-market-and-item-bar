//
//  ProfileCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import XCoordinator

enum ProfileRoute: Route {
    case home
}

class ProfileCoordinator: NavigationCoordinator<ProfileRoute> {
    
    init(){
        super.init(rootViewController: NavigationController(), initialRoute: .home)
        rootViewController.tabBarItem = .profile
    }

    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .home:
            let header = ProfileHeaderInfo(title: "Hello", imageURL: nil, subtitle: nil, subtitle2: nil)
            let profile = ProfilePageViewController(headerInfo: header, menuItems: [])
            
            return .push(profile)
        }
    }
}

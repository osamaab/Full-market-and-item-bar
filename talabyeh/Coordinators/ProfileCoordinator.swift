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
            let header = ProfileHeaderInfo(title: "Hussein AlRyalat", imageURL: URL(string: "http://placekitten.com/g/200/300"), subtitle: "hus.sc@aol.com", subtitle2: "962 79 6979 186")
            let profile = ProfileViewController(headerInfo: header, menuItems: [
                ProfileMenuItem.changePassword(),
                ProfileMenuItem.history(),
                ProfileMenuItem.information()
            ])
            
            
            
            return .push(profile)
        }
    }
}

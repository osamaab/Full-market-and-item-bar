//
//  BannerPageCoordinator.swift
//  Talabia
//
//  Created by Osama Abu hdba on 04/05/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation
import XCoordinator
import Promises

enum BannerPageRoute: Route {
    case banner
}

class BannerPageCoordinator: NavigationCoordinator<BannerPageRoute> {
    
    init(){
        super.init(rootViewController: NavigationController(style: .primary, autoShowsCloseButton: true), initialRoute: .banner)
    }
    
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .banner:
            let vc = BannerPageViewController()
//            vc.delegate = self
            return .push(vc)
        }
    }
}

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
            vc.delegate = self
            return .push(vc)
        }
    }
}

extension BannerPageCoordinator: BannerPageViewControllerDelegate {
    func bannerPageViewController(_ sender: BannerPageViewController, didFinishWith image: Banner) {
        self.rootViewController.performTask(taskOperation: ProfileAPI.updateBanner(image).request(BannerResponse.self)).then {_ in 
            self.rootViewController.showMessage(message: "$", messageType: .success)
            self.performTransition(.dismiss(), with: .init(animated: true))
        }
    }
}

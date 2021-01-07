//
//  CompanyFlowCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 28/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import XCoordinator


extension UITabBarItem {
    static let profile: UITabBarItem = .init(title: "Profile", image: UIImage(named: "profile"), selectedImage: UIImage(named: "profile-selected"))
    
    static let market: UITabBarItem = .init(title: "Market", image: UIImage(named: "market"), selectedImage: UIImage(named: "market-selected"))
    
    static let items: UITabBarItem = .init(title: "Items", image: UIImage(named: "items"), selectedImage: UIImage(named: "items-selected"))
    
    static let distributors: UITabBarItem = .init(title: "Distributors", image: UIImage(named: "distributors"), selectedImage: UIImage(named: "distributors-selected"))

    static let operations: UITabBarItem = .init(title: "Operations", image: UIImage(named: "operations"), selectedImage: UIImage(named: "operations-selected"))

}

enum CompanyFlowRoute: Route {
    case market
    case profile
}

class CompanyFlowCoordinator: TabBarCoordinator<CompanyFlowRoute> {
    
    let marketRouter: StrongRouter<MarketRoute>
    let profileRouter: StrongRouter<ProfileRoute>
    let itemsRouter: StrongRouter<ItemsRoute>
    let distributorsRouter: StrongRouter<DistributorsRoute>
    let operationsRouter: StrongRouter<OperationsRoute>
        
    init(){
        self.marketRouter = MarketCoordinator().strongRouter
        self.profileRouter = ProfileCoordinator().strongRouter
        self.itemsRouter = ItemsCoordinator().strongRouter
        self.distributorsRouter = DistributorsCoordinator().strongRouter
        self.operationsRouter = OperationsCoordinator().strongRouter
        
        super.init(rootViewController: TabBarController(), tabs: [marketRouter, operationsRouter, itemsRouter, distributorsRouter, profileRouter], select: 0)
    }
    
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .market:
            return .select(marketRouter)
        case .profile:
            return .select(profileRouter)
        }
    }
}

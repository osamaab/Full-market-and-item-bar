//
//  ComponentsLabCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 01/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import XCoordinator

enum ComponentsLabRoute: Route {
    case defaultLab
}

class ComponentsLabCoordinator: NavigationCoordinator<ComponentsLabRoute> {
    
    let screensProvider = CLRegisterationSectionListProvider()
    let componentsProvider = CLAutoComponentsSectionListProvider()
    let colorsProvider = CLConstantColorsProvider()
    
    
    init(){
        super.init(rootViewController: NavigationController(autoShowsCloseButton: false), initialRoute: .defaultLab)
    }
    
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .defaultLab:
            let viewController = CLLabViewController(screensProvider: screensProvider,
                                                     componentsProvider: componentsProvider,
                                                     colorsProvider: colorsProvider)
            return .push(viewController)
        }
    }
}

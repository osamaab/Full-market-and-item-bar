//
//  AppCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 28/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import XCoordinator

enum AppRoutes: Route {
    case chooseSignInMethod
    case chooseUserType
    case authentication(AuthenticationRoute)
    case markets(UserType)
    case lab

    case company
    case distributor
    case reseller
    case logout
    
    static func route(for userType: UserType) -> AppRoutes {
        switch userType {
         case .company:
            return .company
        case .distributor:
            return .distributor
        case .reseller:
            return .reseller
        }
    }
    
    static func authRoute(for userType: UserType, categories: [MainCategory]?,subCategories: [SubCategory]? ) -> AppRoutes {
        return .authentication(.signup(userType, categories ?? [], subCategories ?? []))
    }
}

class AppCoordinator: NavigationCoordinator<AppRoutes> {
    
    let preferencesManager = UserDefaultsPreferencesManager.shared
    let authenticationManager = DefaultAuthenticationManager.shared
    
    fileprivate var chooseUserRouter: StrongRouter<ChooseUserRoute>?
    fileprivate var currentFlowCoordinator: Presentable?
    
        
    init(){
        // where we want to go? this can be determinated by the user type, if it exists anyway.
        preferencesManager.didTappedSignUp = false
        let root = NavigationController(autoShowsCloseButton: false)
        
        guard let userType = preferencesManager.userType else {
            super.init(rootViewController: root, initialRoute: .chooseUserType)
            return
        }
        guard self.authenticationManager.isAuthenticated else {
            super.init(rootViewController: root, initialRoute:.chooseUserType )
            return
        }
        
        super.init(rootViewController: root, initialRoute: AppRoutes.route(for: userType))
    }
    
    init(initialRoute: AppRoutes){
        super.init(rootViewController: NavigationController(autoShowsCloseButton: false), initialRoute: initialRoute)
    }
    
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .chooseSignInMethod:
            let viewController = ChooseSignInMethodViewController
            { method in
                switch method {
                case .signUp:
                    self.trigger(.chooseUserType)
                    break
                case .signIn:
                    self.trigger(.authentication(.signin))
                    break
                }
            }
            return .presentFullScreen(viewController)
        case .chooseUserType:
            let coordinator = ChoooseUserCoordinator(delegate: self)
            self.chooseUserRouter = coordinator.strongRouter
            return .presentFullScreen(coordinator)
        case .lab:
            return .multiple(
                .dismissToRoot(),
                .presentFullScreen(ComponentsLabCoordinator()))
        case .company:
            let coordinator = CompanyFlowCoordinator()
            self.currentFlowCoordinator = coordinator
            return .multiple(
                .dismissToRoot(),
                .presentFullScreen(coordinator))
        case .distributor:
            let coordinator = DistributorFlowCoordinator()
            self.currentFlowCoordinator = coordinator
            return .multiple(
                .dismissToRoot(),
                .presentFullScreen(coordinator))
        case .reseller:
            let coordinator = ResellerFlowCoordinator()
            self.currentFlowCoordinator = coordinator
            return .multiple(.dismissToRoot(), .presentFullScreen(coordinator))
        case .authentication(let route):
            let router = AuthenticationCoordinator(delegate: self, initialRoute: route).strongRouter
            return .presentFullScreen(router)
        case .logout:
            preferencesManager.selectedCategories = nil
            preferencesManager.selectedSubCategories = nil
            preferencesManager.userType = nil
            
            currentFlowCoordinator = nil
            authenticationManager.logout()
            
            return .trigger(.chooseSignInMethod, on: self)
        case .markets(let userType):
        switch userType {
        case .company:
            return .trigger(.company, on: self)
        case .reseller:
            return .trigger(.reseller, on: self)
        case .distributor:
            return .trigger(.distributor, on: self)
        }
            }
        }
    }


extension AppCoordinator: ChooseUserCoordinatorDelegate {
    func chooseUserCoordinatorDidChooseLogin(_ sender: ChoooseUserCoordinator) {
        self.trigger(.authentication(.signin))
    }
    
    func chooseUserCoordinator(_ sender: ChoooseUserCoordinator, didChooseSkipWith userType: UserType) {
        
        preferencesManager.userType = userType
        
        self.trigger(.route(for: userType))
    }
    
    func chooseUserCoordinator(_ sender: ChoooseUserCoordinator, didFinishWith output: ChoooseUserCoordinator.Output) {
        
        
        preferencesManager.userType = output.userType
        preferencesManager.selectedCategories = output.categories
        preferencesManager.selectedSubCategories = output.subCategories
        
        if self.preferencesManager.didTappedSignUp == true {
            self.trigger(.authRoute(for: output.userType, categories: output.categories, subCategories: output.subCategories))
        }else if self.preferencesManager.didTappedEditProfile == true {
//            AppDelegate.shared.router.trigger()
        }else {
            self.trigger(.markets(output.userType))
            preferencesManager.didTappedSignUp = false
        }
        
        
    }
}

extension AppCoordinator: AuthenticationCoordinatorDelegate {
    func authenticationCoordinator(_ sender: AuthenticationCoordinator, didFinishWith profile: AuthUserProfile) {
        
        
        DefaultAuthenticationManager.shared.login(with: profile)
        
        preferencesManager.userType = profile.userType
        preferencesManager.selectedCategories = profile.associatedData.interestCategories
        preferencesManager.selectedSubCategories = profile.associatedData.interestSubCategories
        
        self.trigger(.route(for: profile.userType))
    }
}

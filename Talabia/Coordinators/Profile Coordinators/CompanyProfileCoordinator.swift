//
//  ProfileCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import XCoordinator

enum CompanyProfileRoute: Route {
    case notLogin
    
    case profile
    case editProfile
    
    case storeLocations
    case editCategories
    case changePassword
    
    case moreInformation
    case allItems
}

class CompanyProfileCoordinator: NavigationCoordinator<CompanyProfileRoute> {
        
    let preferencesManager = UserDefaultsPreferencesManager.shared
    let authenticationManager = DefaultAuthenticationManager.shared
    
    fileprivate var editCategoriesRouter: StrongRouter<SubCategoriesPickerRoute>?
    fileprivate var changePasswordRouter: StrongRouter<ChangePasswordRoute>?
    fileprivate var editProfileRouter: StrongRouter<EditProfileRoute>?
    fileprivate var itemsRouter: StrongRouter<ItemsRoute>?
    init(){
        
            guard self.authenticationManager.isAuthenticated else {
                super.init(rootViewController: NavigationController(), initialRoute:.notLogin )
                rootViewController.tabBarItem = .profile
                return
            }
            
       super.init(rootViewController: NavigationController(), initialRoute: .profile)
        rootViewController.tabBarItem = .profile
    }

    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .notLogin:
            let vc = chooseSigninOrSignUpViewController
                { method in
                    switch method {
                    case .signUp:
                        self.preferencesManager.didTappedSignUp = true
                        AppDelegate.shared.router.trigger(.chooseUserType, completion: nil)
                        break
                    
                    case .signIn:
                        AppDelegate.shared.router.trigger(.authentication(.signin), completion: nil)
                        break
                    }
                }
            vc.title = "Profile"
            return .push(vc)
        case .profile:
            let profile = CompanyProfileViewController(router: self.unownedRouter)
            profile.title = "Profile"
            return .push(profile)
        case .editProfile:
            guard let company = DefaultAuthenticationManager.shared.authProfile?.associatedData as? Company else {
                return .none()
            }
            
            let router = EditProfileCoordinator(initialRoute: .companyEditProfile(company))
            return .presentFullScreen(router)
        case .storeLocations:
            guard let profile = authenticationManager.authProfile, let asCompany = profile.associatedData as? Company else {
                AppDelegate.shared.router.trigger(.authentication(.signin))
                return .none()
            }
            
            let router = CompanyBranchesCoordinator(company: asCompany)
            return .presentFullScreen(router)
        case .editCategories:
            let coordinator = SubCategoriesPickerCoordinator(initialRoute: .new(.company), delegate: self)
            self.editCategoriesRouter = coordinator.strongRouter
            
            return .presentFullScreen(coordinator)
        case .changePassword:
            let router = ChangePasswordCoordinator()
            return .presentFullScreen(router)
        case .moreInformation:
            return .push(CompanyMoreInformationViewController(delegate: self))
        case .allItems:
            let coordinator = AllItemsCoordinator(rootViewController: NavigationController(style: .secondary, autoShowsCloseButton: true))
            itemsRouter = coordinator.strongRouter
            
            return .presentFullScreen(coordinator)
        }
    }
}


extension CompanyProfileCoordinator: CompanyMoreInformationViewControllerDelegate {
    func companyMoreInformationViewController(_ sender: CompanyMoreInformationViewController, didFinishWith input: CompanyAdditionalInfoInput) {
        

        sender.performTask(taskOperation: ProfileAPI.editAdditionalInfo(input).request(String.self)).then {
            self.rootViewController.showMessage(message: $0, messageType: .success)
            self.rootViewController.popToRootViewController(animated: true)
        }
    }
}

extension CompanyProfileCoordinator: SubCategoriesPickerCoordinatorDelegate {
    func chooseUserCoordinatorDidChooseSkip(_ sender: SubCategoriesPickerCoordinator) {
        
    }
    
    func subCategoriesPickerCoordinator(_ sender: SubCategoriesPickerCoordinator, didFinishWith categories: [SubCategory]) {
        
        
        // perform an api request to edit the categories
    }
}
//extension CompanyProfileCoordinator: ChooseUserCoordinatorDelegate {
//    func chooseUserCoordinator(_ sender: ChoooseUserCoordinator, didFinishWith output: ChoooseUserCoordinator.Output) {
//    }
//
//    func chooseUserCoordinatorDidChooseLogin(_ sender: ChoooseUserCoordinator) {
//    }
//
//    func chooseUserCoordinator(_ sender: ChoooseUserCoordinator, didChooseSkipWith userType: UserType) {
//    }
//
//
//}

//
//  EditProfileCoordinator.swift
//  talabyeh
//
//  Created by Hussein Work on 17/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import XCoordinator
import Promises

enum EditProfileRoute: Route {
    case companyEditProfile(Company)
    case resellerEditProfile(Reseller)
}

class EditProfileCoordinator: NavigationCoordinator<EditProfileRoute> {
    
    init(initialRoute: EditProfileRoute){
        super.init(rootViewController: NavigationController(style: .secondary, autoShowsCloseButton: true), initialRoute: initialRoute)
    }
    
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .companyEditProfile(let company):
            let signUpVC = CompanyEditProfileViewController(company: company)
            signUpVC.delegate = self
            return .push(signUpVC)
        case .resellerEditProfile(let reseller):
            let signUpVC = ResellerEditProfileViewController(reseller: reseller)
            signUpVC.delegate = self
            return .push(signUpVC)
        }
    }
}

extension EditProfileCoordinator: ResellerSignUpViewControllerDelegate {
    func resellerSignUpViewController(sender: ResellerSignUpViewController, didFinishWith reseller: RegisterationForm.Reseller) {


    }
}

extension EditProfileCoordinator: CompanySignUpViewControllerDelegate {
    func companySignUpViewController(_ sender: CompanySignUpViewController, didFinishWith company: RegisterationForm.Company) {

    }
}

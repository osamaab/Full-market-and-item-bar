//
//  SignInViewController.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/11/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia
import Moya
import Promises

protocol SignInViewControllerDelegate: class {
    func signInViewController(_ sender: SignInViewController, didLoginWith profile: AuthUserProfile)
}

class SignInViewController: UIViewController {
    
    let contentView = SignInContentView()
    let userType: UserType
    
    weak var delegate: SignInViewControllerDelegate?
    
    init(userType: UserType){
        self.userType = userType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        view.subviewsPreparedAL {
            contentView
        }
        
        contentView.Top == view.safeAreaLayoutGuide.Top + 20
        contentView.leading(0).trailing(0)
        
        contentView.onAction = { [unowned self] username, password in
            // perform the login..
            
            self.performTask(taskOperation: performLogin(for: self.userType, with: username, password: password)).then { [unowned self] authProfile in
                
                
                self.delegate?.signInViewController(self, didLoginWith: authProfile)
            }
        }
    }
    
    func performLogin(for userType: UserType, with username: String, password: String) -> Promise<AuthUserProfile> {
        
        var _promise: Promise<AuthUserProfile>
        switch userType {
        case .company:
            _promise = AuthenticationAPI.login(username, password).request(Company.self).then { AuthUserProfile.company($0) }
        case .distributor:
            _promise = AuthenticationAPI.login(username, password).request(Distributor.self).then { AuthUserProfile.distributor($0) }
        case .reseller:
            _promise = AuthenticationAPI.login(username, password).request(Reseller.self).then {
                AuthUserProfile.reseller($0)
            }
        }
        
        
        return _promise
    }
}


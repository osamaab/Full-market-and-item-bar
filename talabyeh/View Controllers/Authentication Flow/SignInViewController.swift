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


class SignInViewController: UIViewController {
    
    let contentView = SignInContentView()
    let userType: UserType
    
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
            
            let provider: MoyaProvider<AuthenticationAPI> = MoyaProvider<AuthenticationAPI>.default()
        }
    }
}


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
    func signInViewController(_ sender: SignInViewController, didLoginWith profile: SignInViewController.Output)
}

class SignInViewController: UIViewController {
    
    struct Output {
        let username: String
        let password: String
    }
    let contentView = SignInContentView()
    weak var delegate: SignInViewControllerDelegate?

    override func viewDidLoad() {
        title = "Sign in"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(hex: "#9AA1B1")]
        super.viewDidLoad()
        
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        view.subviewsPreparedAL {
            contentView
        }
        contentView.Top == view.safeAreaLayoutGuide.Top + 20
        contentView.leading(0).trailing(0)
        contentView.Bottom == view.Bottom
        contentView.onAction = { [unowned self] username, password in
            
            self.delegate?.signInViewController(self, didLoginWith: .init(username: username, password: password))
        }
    }
}


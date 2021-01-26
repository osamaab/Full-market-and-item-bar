//
//  SignInViewController.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/11/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate
{
    
    let signInView = SignInView()
    
    override func loadView() {
        view = signInView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        signInView.backButton.addTarget(self, action: #selector(backButton), for: .touchUpInside)
        signInView.signInButton.addTarget(self, action: #selector(signInButton), for: .touchUpInside)
    }
    
    
    @objc func backButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func signInButton() {
    }
}

//
//  SignInViewController.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/11/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
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
        

    }


@objc func backButton()
{
    self.navigationController?.popViewController(animated: true)
}
    



}

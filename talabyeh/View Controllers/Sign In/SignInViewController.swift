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
        signInView.signInButton.addTarget(self, action: #selector(signInButton), for: .touchUpInside)
        
        
    }
    
    
    @objc func backButton()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func signInButton()
    {
        let mainVC = UITabBarController()
        let profileVC = ProfilePageViewController()
        mainVC.setViewControllers([profileVC], animated: true)
        mainVC.modalTransitionStyle = .crossDissolve
        mainVC.modalPresentationStyle = .fullScreen
        //mainVC.tabBar.frame.size.height = 82.81
        //mainVC.tabBar.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.present(mainVC, animated: true, completion: nil)
    }
    
    
    
}

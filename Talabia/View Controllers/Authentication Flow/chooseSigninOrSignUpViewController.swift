//
//  chooseSigninOrSignUpViewController.swift
//  talabyeh
//
//  Created by Osama Abu hdba on 29/03/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

protocol chooseSigninOrSignUpViewControllerDelegate: class {
    func goToChooseUserAndSignUp()-> Void
}

class chooseSigninOrSignUpViewController: UIViewController {

    enum Method {
        case signIn
        case signUp
    }

    let contentView = chooseSigninOrSignUpcontentView()
    let action: ((Method) -> Void)
    weak var delegate: chooseSigninOrSignUpViewControllerDelegate?
    
    init(action: @escaping ((Method) -> Void)) {
        self.action = action
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), action: {
        self.navigationController?.popViewController(animated: true)})
        super.viewDidLoad()

        
        view.subviewsPreparedAL {
            contentView
        }
        
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        contentView.centerVertically().leading(30).trailing(30).top(10)
        contentView.signInButton.add(event: .touchUpInside) { [weak self] in
            self?.action(.signIn)
        }
        
        contentView.signUpButton.add(event: .touchUpInside) { [weak self] in
            self?.action(.signUp)
        }
    }
}

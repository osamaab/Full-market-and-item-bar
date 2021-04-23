//
//  ChooseSignInMethodViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 11/03/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

class ChooseSignInMethodViewController: UIViewController {
    
    enum Method {
        case signIn
        case signUp
    }

    let contentView = ChooseSignInMethodContentView()
    let action: ((Method) -> Void)
    
    init(action: @escaping ((Method) -> Void)) {
        self.action = action
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), action: {
            AppDelegate.shared.router.trigger(.chooseUserType)
        })
        // Do any additional setup after loading the view.
        view.subviewsPreparedAL {
            contentView
        }
        
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        contentView.Top == view.safeAreaLayoutGuide.Top + 15
        contentView.centerVertically().centerHorizontally().leading(30)
        
        contentView.signInButton.add(event: .touchUpInside) { [unowned self] in
            self.action(.signIn)
        }
        
        contentView.signUpButton.add(event: .touchUpInside) { [unowned self] in
            self.action(.signUp)
        }
    }
}

class ChooseSignInMethodContentView: BasicViewWithSetup {
    
    let imageView = UIImageView().then {
        $0.image = UIImage(named: "logo")
        $0.contentMode = .scaleAspectFit
    }
    
    
    let titleLabel = UILabel().then {
        $0.font = .font(for: .bold, size: 27)
        $0.textColor = DefaultColorsProvider.tintPrimary
        $0.textAlignment = .center
        $0.text = "Welcome"
    }
    
    let signInButton = RoundedButton().then{
        $0.backgroundColor = DefaultColorsProvider.tintSecondary
        $0.setTitleColor(DefaultColorsProvider.tintPrimary, for: .normal)
        $0.titleLabel?.font = .font(for: .bold, size: 16)
        $0.setTitle("Login", for: .normal)
        
        $0.layer.borderWidth = 1
        $0.layer.borderColor = DefaultColorsProvider.tintPrimary.cgColor
        $0.contentEdgeInsets = .init(top: 12, left: 70, bottom: 12, right: 70)
    }
    
    let signUpButton = RoundedButton().then {
        $0.backgroundColor = DefaultColorsProvider.backgroundPrimary
        $0.setTitleColor(DefaultColorsProvider.tintPrimary, for: .normal)
        $0.titleLabel?.font = .font(for: .bold, size: 16)
        $0.setTitle("Register", for: .normal)
        
        $0.layer.borderWidth = 1
        $0.layer.borderColor = DefaultColorsProvider.tintPrimary.cgColor
        $0.contentEdgeInsets = .init(top: 12, left: 70, bottom: 12, right: 70)
    }
    
    override func setup() {
        let containerStackView = UIStackView()
        
        
        containerStackView.alignment(.center)
            .distribution(.fill)
            .spacing(100)
            .axis(.vertical)
        
        subviewsPreparedAL {
            containerStackView
        }
        
        containerStackView.top(>=0).leading(0).centerHorizontally().centerVertically()
        
        let buttonsStacckView = UIStackView()
        
        buttonsStacckView.alignment(.fill)
            .distribution(.fillEqually)
            .spacing(15)
            .axis(.vertical)
        
        buttonsStacckView.addingArrangedSubviews {
            signInButton
            signUpButton
        }
        
        containerStackView.addingArrangedSubviews {
            imageView
            titleLabel
            buttonsStacckView
        }
        

        
        imageView.width(175)
    }
}

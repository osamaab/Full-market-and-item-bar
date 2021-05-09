//
//  ChangePasswordViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 16/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

protocol ChangePasswordViewControllerDelegate: class {
    func changePasswordViewController(_ sender: ChangePasswordViewController, didFinishWith output: ChangePasswordViewController.Output)
}

class ChangePasswordViewController: UIViewController {
    
    struct Output {
        let oldPassword: String
        let newPassword: String
    }

    let saveButtonView = BottomNextButtonView(title: "Save")
    let contentView = ChangePasswordContentView()
    
    weak var delegate: ChangePasswordViewControllerDelegate?
    
    override func viewDidLoad() {
        title = "Change Password"
        super.viewDidLoad()

        // Do any additional setup after loading the view.        
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        view.subviewsPreparedAL {
            contentView
            saveButtonView
        }
        
        contentView.leading(20).trailing(20)
        contentView.Top == view.safeAreaLayoutGuide.Top + 30
        
        saveButtonView.leading(0).trailing(0).bottom(0)
        
        saveButtonView.nextButton.add(event: .touchUpInside){ [unowned self] in
            guard let old = self.contentView.oldPasswordField.text,
                  let new = self.contentView.newPasswordField.text,
                  let confirmNew = self.contentView.confirmNewPasswordField.text,
                  !old.isEmpty,
                  !new.isEmpty,
                  !confirmNew.isEmpty else {
                self.showMessage(message: "Please Fill all fields", messageType: .failure)
                return
            }
            
            if new != confirmNew {
                self.showMessage(message: "Passwords do not match", messageType: .failure)
                return
            }
            
            self.delegate?.changePasswordViewController(self, didFinishWith: .init(oldPassword: old, newPassword: new))
        }
    }
}

//
//  KeyboardSetupStep.swift
//  talabyeh
//
//  Created by Hussein Work on 05/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import IQKeyboardManager


extension DefaultSetupSteps {
    struct KeyboardSetupStep: AppSetupStepType {
        func setup(for application: UIApplication, delegate: AppDelegate, launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
            IQKeyboardManager.shared().isEnabled = true
        }
    }
}

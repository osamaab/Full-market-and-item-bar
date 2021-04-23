//
//  ApperanceSetupStep.swift
//  talabyeh
//
//  Created by Osama Abu hdba on 28/03/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit

extension DefaultSetupSteps {
    struct ApperanceSetupStep: AppSetupStepType {
        func setup(for application: UIApplication, delegate: AppDelegate, launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {

            UIBarButtonItem.appearance().setTitleTextAttributes([
                .font: UIFont.font(for: .bold, size: 17)
            ], for: .normal)
        }
    }
}

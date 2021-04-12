//
//  AppSetupStepType.swift
//  talabyeh
//
//  Created by Hussein Work on 05/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit

protocol AppSetupStepType {
    func setup(for application: UIApplication, delegate: AppDelegate, launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
}

@_functionBuilder
struct AppSetupStepsBuilder {
    static func buildBlock(_ partialResults: AppSetupStepType...) -> [AppSetupStepType] {
        partialResults
    }
}

struct DefaultSetupSteps: AppSetupStepType {
    
    fileprivate var children: [AppSetupStepType]
    
    init(@AppSetupStepsBuilder builder: () -> [AppSetupStepType]){
        self.children = builder()
    }
    
    func setup(for application: UIApplication, delegate: AppDelegate, launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        children.forEach {
            $0.setup(for: application, delegate: delegate, launchOptions: launchOptions)
        }
    }
}

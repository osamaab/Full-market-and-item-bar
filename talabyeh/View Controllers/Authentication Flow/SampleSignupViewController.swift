//
//  SampleSignupViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 11/12/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class SampleSignupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = DefaultColorsProvider.background
        
        let photoView = PickerPlaceholderView()
        let logoView = PickerPlaceholderView()
        
        let locationView = PickerPlaceholderView()
        let categoryView = PickerPlaceholderView()
        
        [photoView, logoView, locationView, categoryView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let topStack = UIStackView()
        topStack.axis(.horizontal).alignment(.fill).distribution(.fillEqually).spacing(15).preparedForAutolayout()
        
        let bottomStack = UIStackView()
        bottomStack.axis(.horizontal).alignment(.fill).distribution(.fillEqually).spacing(15).preparedForAutolayout()

        topStack.arrangedSubviews([photoView, logoView])
        bottomStack.arrangedSubviews([locationView, categoryView])
        
        let containerStack = UIStackView()
        containerStack.alignment(.fill).axis(.vertical).distribution(.fillEqually).spacing(15).preparedForAutolayout()
        
        containerStack.arrangedSubviews([topStack, bottomStack])
        
        view.addSubview(containerStack)
        containerStack.leading(25).centerHorizontally()
        containerStack.Top == view.safeAreaLayoutGuide.Top + 25
    }
}

//
//  DistributorSignUpViewController.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/21/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class DistributorSignUpViewController: UIViewController {
    
    lazy var scrollView: ScrollContainerView = .init(contentView: contentView)
    lazy var contentView = DistributorSignUpContentView()
    lazy var bottomNextView: BottomNextButtonView = .init(title: "Save")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        addValidation()
    }
    
    func setupViews(){
        view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
        view.subviewsPreparedAL {
            scrollView
            bottomNextView
        }
        
        scrollView.Top == view.safeAreaLayoutGuide.Top + 20
        scrollView.leading(20).trailing(20).bottom(0)
        
        bottomNextView.leading(0).trailing(0).bottom(0)
    }
    
    func addValidation(){
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.scrollView.contentInset.bottom = bottomNextView.bounds.height + 15
    }
}

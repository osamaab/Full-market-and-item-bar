//
//  NewItemViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 21/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

class NewItemViewController: UIViewController {
    
    let categoryView = TintedLabelCollectionReusableView(verticalPadding: 20, horizontalPadding: 20)
    let fieldsInputView = NewItemInputFieldsContentView()
    let bottomNextView = BottomNextButtonView(title: "Next")
    
    lazy var scrollView: ScrollContainerView = .init(contentView: fieldsInputView)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = DefaultColorsProvider.backgroundSecondary
        
        view.subviewsPreparedAL {
            categoryView
            scrollView
            bottomNextView
        }
        
        categoryView.Top == view.safeAreaLayoutGuide.Top + 20
        categoryView.leading(20).trailing(20)
        
        scrollView.Top == categoryView.Bottom + 20
        scrollView.leading(0).trailing(0).bottom(0)
        
        bottomNextView.bottom(0).leading(0).trailing(0)
        
        
        categoryView.titleLabel.font = .font(for: .semiBold, size: 17)
        categoryView.title = "Cats"
        
        
        fieldsInputView.backgroundColor = DefaultColorsProvider.backgroundPrimary
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.scrollView.contentInset.bottom = bottomNextView.bounds.height
    }
}

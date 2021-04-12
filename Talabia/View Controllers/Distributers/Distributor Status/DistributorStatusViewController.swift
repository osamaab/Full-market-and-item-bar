//
//  DistributorStatusViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 24/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

class DistributorStatusViewController: UIViewController {

    lazy var scrollContainerView: ScrollContainerView = .init(contentView: contentView)
    lazy var contentView: DistributorStatusContentView = .init()
    lazy var bottomView: BottomNextButtonView = .init(title: "Save")

    let distributor: Distributor
    
    init(distributor: Distributor){
        self.distributor = distributor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
        
        bottomView.nextButton.add(event: .touchUpInside) {
            
        }
        
        navigationItem.title = "Status"
    }
    
    fileprivate func setupViews(){
        self.view.backgroundColor = DefaultColorsProvider.backgroundSecondary
        
        scrollContainerView.translatesAutoresizingMaskIntoConstraints = false
        scrollContainerView.scrollView.contentInset.bottom += 100
        scrollContainerView.scrollView.contentInset.top += 20
        
        view.subviews {
            scrollContainerView
            bottomView
        }
        
        scrollContainerView.left(20).right(20)
        scrollContainerView.Top == view.safeAreaLayoutGuide.Top
        scrollContainerView.Bottom == view.Bottom
        
        bottomView.right(0).left(0).bottom(0)
    }
}

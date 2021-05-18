//
//  CompanyMoreInformationViewController.swift
//  Talabia
//
//  Created by Osama Abu hdba on 17/05/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia
import XCoordinator

class CompanyMoreInfoViewController: UIViewController {

    //MARK: Views
    let contentView: CheckoutContentView = .init()
    
    let certificateCard = CertificatesCardView()
    let profileCard = CompanyProfileCardView()
    let ratingView = CompanyReview()
    let deliverToView = DeliveredCardView()
    
    
    //MARK: Dependencies
    
    let router: UnownedRouter<MarketRoute>
    
    internal init(router: UnownedRouter<MarketRoute>) {
        self.router = router
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = DefaultColorsProvider.backgroundSecondary
        hidesBottomBarWhenPushed = true
        
        setupViews()
        setupCardViews()
        addBackButton()
    }
    
    fileprivate func setupViews(){
        self.view.backgroundColor = DefaultColorsProvider.backgroundSecondary
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.scrollContainerView.scrollView.contentInset.bottom += 100
        contentView.scrollContainerView.scrollView.contentInset.top += 20
        
        view.subviews {
            contentView
        }
        
        contentView.left(0).right(0)
        contentView.Top == view.safeAreaLayoutGuide.Top
        contentView.Bottom == view.safeAreaLayoutGuide.Bottom
        
        navigationItem.title = "Abwab Alsalam"
    }
    
    fileprivate func setupCardViews(){
        contentView.insertCardView(with: ratingView, title: nil)
        contentView.insertCardView(with: certificateCard, title: nil)
        contentView.insertCardView(with: profileCard, title: nil)
        contentView.insertCardView(with: deliverToView, title: nil)
      
        

    }
    func addBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.addTarget(self, action: #selector(self.backAction(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    @objc func backAction(_ sender: UIButton) {
        let _ = navigationController?.popViewController(animated: true)
    }
}

//
//  FavoritesViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 22/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia
import XCoordinator

class FavoritesContainerViewController: UIViewController {
        
    let segmentedControl = BigSegmentedControl(items: ["Items", "Companies"])
    
    let favoritedProductsViewController: FavoritedProductsViewController
    let favoritedCompaniesViewController: FavoritedCompaniesViewController
    
    let router: UnownedRouter<FavoritesRoute>
    
    init(router: UnownedRouter<FavoritesRoute>){
        self.router = router
        self.favoritedProductsViewController = .init(router: router)
        self.favoritedCompaniesViewController = .init(router: router)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favourites"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"search-Icon"), action: {})

        // Do any additional setup after loading the view.
        view.backgroundColor = DefaultColorsProvider.backgroundSecondary
             
        view.subviewsPreparedAL {
            segmentedControl
        }
        
        segmentedControl.Top == view.safeAreaLayoutGuide.Top + 10
        segmentedControl.leading(20).trailing(20)
        segmentedControl.height(50)
        segmentedControl.select(index: 0, animated: true)
        
        segmentedControl.add(event: .valueChanged){ [unowned self] in
            self.select(index: segmentedControl.selectedIndex ?? 0, retryIfNeeded: true)
        }
        
        // setting up view controllers
        addChild(favoritedProductsViewController)
        addChild(favoritedCompaniesViewController)
        
        view.subviewsPreparedAL {
            favoritedProductsViewController.view!
            favoritedCompaniesViewController.view!
        }
        
        [favoritedProductsViewController.view!, favoritedCompaniesViewController.view!].forEach {
            $0.Top == segmentedControl.Bottom + 20
            $0.Bottom == view.safeAreaLayoutGuide.Bottom
            $0.Leading == view.Leading
            $0.Trailing == view.Trailing
        }
        
        
        favoritedProductsViewController.didMove(toParent: self)
        favoritedCompaniesViewController.didMove(toParent: self)
        
        self.select(index: 0, retryIfNeeded: false)
    }
    
    func select(index: Int, retryIfNeeded: Bool){
        self.favoritedProductsViewController.view.isHidden = index != 0
        self.favoritedCompaniesViewController.view.isHidden = index != 1
        
        
        guard retryIfNeeded else { return }
        
        if index == 0 {
            favoritedProductsViewController.retry()
        }
        
        if index == 1 {
            favoritedCompaniesViewController.retry()
        }
    }
}




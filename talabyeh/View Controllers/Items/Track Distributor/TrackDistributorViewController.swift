//
//  TrackDistributorViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 22/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import MapKit
import Stevia


// Common issue: the next view doesn't hide upon tapping on the background, this due the action doesn't get received on the next Button
class TrackDistributorViewController: UIViewController {

    let menuView = TrackDistributorMenuView()
    let mapView = MKMapView()
    let nextView: BottomNextButtonView = .init(title: "Next")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = DefaultColorsProvider.backgroundSecondary
        
        view.subviewsPreparedAL {
            menuView
            mapView
            nextView
        }
        
        menuView.Top == view.safeAreaLayoutGuide.Top
        menuView.leading(0).trailing(0)
        
        mapView.Bottom == view.safeAreaLayoutGuide.Bottom
        mapView.Top == menuView.Bottom
        mapView.leading(0).trailing(0)
        
        nextView.leading(0).trailing(0).bottom(0)
        
        nextView.isHidden = true
        
        menuView.add(event: .valueChanged) { [unowned self] in
            self.nextView.isHidden = false
        }
        
        nextView.nextButton.add(event: .touchUpInside) {  [unowned self] in
            self.menuView.hideMenu()
            self.nextView.isHidden = true
        }
    }
}

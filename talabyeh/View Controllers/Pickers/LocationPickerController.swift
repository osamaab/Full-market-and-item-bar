//
//  LocationPickerController.swift
//  talabyeh
//
//  Created by Hussein Work on 11/12/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

private let nextButtonTitle = "Next"
private let searchPlaceholder = "City / Street / Building no. / office"

typealias PickedLocation = Location

protocol LocationPickerControllerDelegate: class {
    func locationPickerController(_ sender: LocationPickerController, didFinishWith location: PickedLocation?)
}

class LocationPickerController: NSObject {
    
    /**
     This is not a singltone object, we just need to keep reference to the current controller, so clients can benifit without referencing the controller itself
     */
    private static var current: LocationPickerController?
    
    private var locationPicker: LocationPickerViewController
    private var navigationController: UINavigationController
    private var nextButtonView: BottomNextButtonView
    
    let title: String
    
    weak var delegate: LocationPickerControllerDelegate?
    
    fileprivate(set) var location: PickedLocation?
    
    init(title: String, location: PickedLocation?, delegate: LocationPickerControllerDelegate){
        self.title = title
        self.location = location
        self.delegate = delegate

        self.locationPicker = LocationPickerViewController()
        self.navigationController = UINavigationController(rootViewController: locationPicker)
        
        self.nextButtonView = .init()
        self.nextButtonView.nextButton.setTitle("Next", for: .normal)
        
        super.init()
        Self.current = self
        
        self.nextButtonView.nextButton.add(event: .touchUpInside) { [unowned self] in
            if let location = self.locationPicker.location {
                self.select(location: location)
            }
        }
    }
    
    func select(location: Location?){
        self.locationPicker.dismiss(animated: true, completion: nil)
        self.delegate?.locationPickerController(self, didFinishWith: location)
        Self.current = nil
    }
    
    
    func present(on controller: UIViewController){
        locationPicker.location = self.location

        // button placed on right bottom corner
        locationPicker.showCurrentLocationButton = true // default: true

        // default: navigation bar's `barTintColor` or `UIColor.white`
        locationPicker.currentLocationButtonBackground = .white

        // ignored if initial location is given, shows that location instead
        locationPicker.showCurrentLocationInitially = true

        locationPicker.mapType = .standard

        // for searching, see `MKLocalSearchRequest`'s `region` property
        locationPicker.useCurrentLocationAsHint = true

        locationPicker.searchBarPlaceholder = searchPlaceholder

        // optional region distance to be used for creation region when user selects place from search results
        locationPicker.resultRegionDistance = 500 // default: 600

        locationPicker.completion = { location in
            // do some awesome stuff with location
            
            self.select(location: location)
        }
        
        locationPicker.view.addSubview(nextButtonView)
        nextButtonView.translatesAutoresizingMaskIntoConstraints = false
        nextButtonView.bottom(0).leading(0).centerHorizontally()
        
        locationPicker.navigationItem.title = title
        navigationController.modalPresentationStyle = .fullScreen
        
        controller.present(navigationController, animated: true, completion: nil)
    }
}

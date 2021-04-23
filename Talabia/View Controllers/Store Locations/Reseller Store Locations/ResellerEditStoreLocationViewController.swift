//
//  ResellerEditStoreLocationViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 15/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import CoreLocation

class ResellerEditStoreLocationViewController: ResellerNewStoreLocationViewController {

    let originalStoreLocation: StoreLocation
    
    override var targetID: Int? {
        originalStoreLocation.id
    }
    
    init(storeLocation: StoreLocation){
        self.originalStoreLocation = storeLocation
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        navigationItem.title = "Edit Store Location"
        
        if let locationLat = Double(originalStoreLocation.lat),
              let locationLon = Double(originalStoreLocation.lng)  {
            let location = CLLocation(latitude: locationLat, longitude: locationLon)
            
            self.contentView.locationTextField.location = PickedLocation(name: nil, location: location, placemark: nil)
        }
        
        
        self.contentView.nameTextField.text = originalStoreLocation.name
        self.contentView.streetTextField.text = originalStoreLocation.streetName
        self.contentView.buildingTextField.text = originalStoreLocation.buildingName
        self.contentView.floorTextField.text = originalStoreLocation.floor
        self.contentView.additionalInfoTextField.text = originalStoreLocation.additionalDirections
        
        //TODO: map the from time, and to time, + working days to the text field picker :))))        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

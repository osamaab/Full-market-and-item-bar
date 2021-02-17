//
//  CompanyEditStoreLocationViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 15/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import CoreLocation

class CompanyEditStoreLocationViewController: CompanyNewStoreLocationViewController {

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
                
        if let locationLat = Double(originalStoreLocation.lat),
              let locationLon = Double(originalStoreLocation.lng)  {
            let location = CLLocation(latitude: locationLat, longitude: locationLon)
            
            self.locationInfoCard.locationTextField.location = PickedLocation(name: nil, location: location, placemark: nil)
        }
        
        
        self.locationInfoCard.nameTextField.text = originalStoreLocation.name
        self.locationInfoCard.streetTextField.text = originalStoreLocation.streetName
        self.locationInfoCard.buildingTextField.text = originalStoreLocation.buildingName
        self.locationInfoCard.floorTextField.text = originalStoreLocation.floor
        self.locationInfoCard.additionalInfoTextField.text = originalStoreLocation.additionalDirections
        
        //TODO: map the from time, and to time, + working days to the text field picker :))))
        
        self.contactInfoCard.faxTextField.text = originalStoreLocation.faxes?.first?.fax
        self.contactInfoCard.emailTextField.text = originalStoreLocation.emails?.first?.email
        self.contactInfoCard.telephoneTextField.text = originalStoreLocation.phones?.first?.phone

        self.deliveryInfoCard.cities = originalStoreLocation.coveringAreas?.map { $0.city } ?? []
        self.deliveryInfoCard.deliveryOptionView.isChecked = originalStoreLocation.allowDelivery ?? false
        self.deliveryInfoCard.pickupOptionView.isChecked = originalStoreLocation.allowPickup ?? false
        self.deliveryInfoCard.updateStatusViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  ResellerEditProfileViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 17/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit

class ResellerEditProfileViewController: ResellerSignUpViewController {
    let reseller: Reseller
    
    init(reseller: Reseller){
        self.reseller = reseller
        super.init(categories: reseller.categories , subCategories: reseller.subCategories ?? [] )
//        super.init(categories: reseller.categories.reduce(into: [], { $0 + $1.subcategories}))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let lat = Double(reseller.lat), let lng = Double(reseller.lng) {
            self.storeLocation = Location(name: nil, location: .init(latitude: lat, longitude: lng))
        }
        
        contentView.emailtf.isHidden = true
        contentView.passwordtf.isHidden = true
        
        contentView.nationalNumbertf.text = reseller.commercialLicense
        contentView.nametf.text = reseller.name
        contentView.telephonetf.text = reseller.telephone
    }
    
    override func verifyContent() throws -> RegisterationForm.Reseller {
        guard let name = self.contentView.nametf.text,
              let nationalNumber = self.contentView.nationalNumbertf.text,
              let telephone = self.contentView.telephonetf.text else {
            throw InputCardViewValidationError.missingFields
        }
        
        let logo64Base = self.logoImage?.toBase64()
        
        let lat: String
        let lon: String
        
        if let location = self.storeLocation {
            lat = "\(location.location.coordinate.latitude)"
            lon = "\(location.location.coordinate.longitude)"
        } else {
            lat = reseller.lat
            lon = reseller.lng
        }
        
//        let form = RegisterationForm.Reseller(enName: name, email: email, password: password, facilityNationalNumber: nationalNumber, telephone: telephone, lat: lat, lng: lon, logoB64: logo64Base, categories:
//                                                categories.compactMap { CategoriesIDInput(id:$0.id) }, subcategories: subCategories.compactMap{ SubCategoriesIDInput(id:$0.id) })
//
//        return form
//    }
        
        
        let form = RegisterationForm.Reseller(enName: name, email: nil, password: nil, facilityNationalNumber: nationalNumber, telephone: telephone, lat: lat, lng: lon, logoB64: logo64Base, categories:
                                                            categories.compactMap { CategoriesIDInput(id:$0.id) }, subcategories: subCategories.compactMap{ SubCategoriesIDInput(id:$0.id) })
            
                    return form
    }

}
//    override func updatePickersState(){
//        // fill values with dummy data
//        
//        contentView.categoryView.associatedValue = categories as AnyObject?
//        contentView.storeImageView.associatedValue = NSString()
//        contentView.storeLocationView.associatedValue = NSString()
//        contentView.licenceView.associatedValue = NSString()
//    }
//}


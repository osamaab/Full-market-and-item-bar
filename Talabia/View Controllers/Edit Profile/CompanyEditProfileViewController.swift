//
//  CompanyEditProfileViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 17/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit

class CompanyEditProfileViewController: CompanySignUpViewController {
    
    let company: Company
    
    init(company: Company){
        self.company = company
        super.init(categories: company.categories ?? [], subCategories: company.subcategories ?? [])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let lat = Double(company.lat ?? ""), let lng = Double(company.lng ?? "") {
            self.companyLocation = Location(name: nil, location: .init(latitude: lat, longitude: lng))
        }
        
        contentView.emailtf.isHidden = true
        contentView.passwordtf.isHidden = true
        
        contentView.nationalNumbertf.text = company.nationalNumber
        contentView.companytf.text = company.title
        contentView.telephonetf.text = company.telephone
    }
    
    override func verifyContent() throws -> RegisterationForm.Company {
        guard let companyTF = self.contentView.companytf.text,
              let nationalNumber = self.contentView.nationalNumbertf.text,
              let telephone = self.contentView.telephonetf.text else {
            throw InputCardViewValidationError.missingFields
        }
        
        let logo64Base = self.logoImage?.toBase64()
        let lat: String
        let lon: String
        
        if let location = self.companyLocation {
            lat = "\(location.location.coordinate.latitude)"
            lon = "\(location.location.coordinate.longitude)"
        } else {
            lat = company.lat ?? ""
            lon = company.lng ?? ""
        }
        
        
        let form = RegisterationForm.Company(enTitle: companyTF, email: nil, password: nil, nationalNumber: nationalNumber, telephone: telephone, lat: lat, lng:lon, logoB64: logo64Base, categories:categories.compactMap { CategoriesIDInput(id:$0.id) }, subcategories: subCategories.compactMap{ SubCategoriesIDInput(id:$0.id)})
                                                

        return form
    }
    
    override func updatePickersState(){
        // fill values with dummy data
        
        contentView.categoryView.associatedValue = categories as AnyObject?
        contentView.companyLogoView.associatedValue = NSString()
        contentView.comLicenceView.associatedValue = NSString()
        contentView.companyLocationView.associatedValue = NSString()
    }
}

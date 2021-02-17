//
//  NewCompanyBranchViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 08/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia


protocol CompanyNewStoreLocationViewControllerDelegate: class {
    func companyNewStoreLocationViewController(_ sender: CompanyNewStoreLocationViewController, didFinishWith location: NewStoreLocation)
}

class CompanyNewStoreLocationViewController: UIViewController {
    
    let contentView: NewCompanyBranchContentView = .init()
    let bottomView: BottomNextButtonView = .init(title: "Save")

    let locationInfoCard = BasicLocationInformationContentView()
    let workingDaysInfoCard = TimeInformationContentView()
    let contactInfoCard = ContactInformationContentView()
    let deliveryInfoCard = DeliveryInformationContentView()
    let branchStatusCard = BranchStatusContentView()
    
    weak var delegate: CompanyNewStoreLocationViewControllerDelegate?
    
    var targetID: Int? {
        nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        hidesBottomBarWhenPushed = true
        setupViews()
        setupCardViews()
        
        bottomView.add(gesture: .tap(1)){ [unowned self] in
            // now perform the save..
            
            self.inspectFieldsAndSave()
        }
    }
    
    fileprivate func inspectFieldsAndSave(){
        // group the outputs, and report any validation errors
        
        do {
            let locationInfo = try locationInfoCard.validateAndReturnData()
            let timeInfo = try workingDaysInfoCard.validateAndReturnData()
            let contactInfo = try contactInfoCard.validateAndReturnData()
            let deliveryInfo = try deliveryInfoCard.validateAndReturnData()
//            let statusInfo = try branchStatusCard.validateAndReturnData()
            
            
            // now we need to map the working days and working times into working day input
            let workingDays = (timeInfo.startWeekday.rawValue...timeInfo.endWeekday.rawValue).compactMap { Weekday(rawValue: $0) }.map {
                WorkingDayInput(dayId: $0.rawValue, timeFrom: timeInfo.firstTime, timeTo: timeInfo.endTime)
            }
            
            
            
            // group them all togather into a newlocation form
            let newLocation = NewStoreLocation(id: targetID, name: locationInfo.name,
                             lat: locationInfo.latitude, lng: locationInfo.longitude,
                             streetName: locationInfo.street,
                             buildingName: locationInfo.building,
                             floor: locationInfo.floor,
                             additionalDirections: locationInfo.additionalInfo,
                             allowDelivery: deliveryInfo.availableForDelivery,
                             allowPickup: deliveryInfo.availableForPickup,
                             phones: contactInfo.telephones.map { PhoneInput(phone: $0) },
                             fax: contactInfo.faxes.map { FaxInput(fax: $0) },
                             emails: contactInfo.emails.map { EmailInput(email: $0) },
                             coveringAreas: deliveryInfo.cities.map { CoveringAreaInput(cityId: $0.id) },
                             workingDays: workingDays)
            
            self.delegate?.companyNewStoreLocationViewController(self, didFinishWith: newLocation)
        } catch let error as InputCardViewValidationError {
            switch error {
            case .missingFields:
                self.showMessage(message: "Please complete all fields", messageType: .failure)
            }
        } catch {
            self.showMessage(message: error.localizedDescription, messageType: .failure)
        }
    }
    
    fileprivate func setupViews(){
        self.view.backgroundColor = DefaultColorsProvider.backgroundSecondary
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.scrollContainerView.scrollView.contentInset.bottom += 100
        
        view.subviews {
            contentView
            bottomView
        }
        
        contentView.left(0).right(0)
        contentView.Top == view.safeAreaLayoutGuide.Top
        contentView.Bottom == view.safeAreaLayoutGuide.Bottom
        
        bottomView.right(0).left(0).bottom(0)
    }
    
    fileprivate func setupCardViews(){
        // insert card views here..
        contentView.insertCardView(with: locationInfoCard, title: "Company Location ( Offices, Manufa.. )")
        contentView.insertCardView(with: workingDaysInfoCard, title: "Working time")
        contentView.insertCardView(with: contactInfoCard, title: "Contact Details")
        contentView.insertCardView(with: deliveryInfoCard, title: "Delivery Information")
        contentView.insertCardView(with: branchStatusCard, title: "Status")
    }
}

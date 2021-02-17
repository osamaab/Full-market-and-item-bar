//
//  ResellerNewStoreLocationViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 15/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia


protocol ResellerNewStoreLocationViewControllerDelegate: class {
    func resellerNewStoreLocationViewController(_ sender: ResellerNewStoreLocationViewController, didFinishWith location: NewStoreLocation)
}

class ResellerNewStoreLocationViewController: UIViewController {

    lazy var scrollContainerView: ScrollContainerView = .init(contentView: contentView)
    lazy var contentView: NewResellerStoreLocationContentView = .init()
    lazy var bottomView: BottomNextButtonView = .init(title: "Save")
        
    var targetID: Int? {
        nil
    }
    
    weak var delegate: ResellerNewStoreLocationViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        hidesBottomBarWhenPushed = true
        setupViews()
        
        bottomView.add(gesture: .tap(1)){ [unowned self] in
            // now perform the save..
            
            self.inspectFieldsAndSave()
        }
        
        navigationItem.title = "New Store Location"
    }
    
    fileprivate func inspectFieldsAndSave(){
        // group the outputs, and report any validation errors
        
        do {
            let locationInfo = try contentView.validateAndReturnData()
            
            // now we need to map the working days and working times into working day input
            let workingDays = (locationInfo.startWeekday.rawValue...locationInfo.endWeekday.rawValue).compactMap { Weekday(rawValue: $0) }.map {
                WorkingDayInput(dayId: $0.rawValue, timeFrom: locationInfo.firstTime, timeTo: locationInfo.endTime)
            }
            
            let newStoreLocation = NewStoreLocation.resellerStoreLocation(id: self.targetID, name: locationInfo.name, lat: locationInfo.latitude, lng: locationInfo.longitude, streetName: locationInfo.street, buildingName: locationInfo.building, floor: locationInfo.floor, additionalDirections: locationInfo.additionalInfo, workingDays: workingDays)
            

            
            self.delegate?.resellerNewStoreLocationViewController(self, didFinishWith: newStoreLocation)
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
        self.view.backgroundColor = DefaultColorsProvider.backgroundPrimary
        
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

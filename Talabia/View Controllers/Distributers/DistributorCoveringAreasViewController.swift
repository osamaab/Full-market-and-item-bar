//
//  DistributorCoveringAreasViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 24/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit

class DistributorCoveringAreasViewController: CityPickerViewController {
    
    let distributor: Distributor
    
    init(distributor: Distributor){
        self.distributor = distributor
        super.init(contentRepository: APIContentRepositoryType<GeneralAPI, [CityItem]>(.areas))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func contentRequestWillStart() {
        // try to fetch the selected items..
        self.selectionMode = .multiple
        
        DistributorsAPI.coveringAreas.request([APICoveringArea].self).then {
            self.selectedOptions = Set($0.map { $0.city })
            self.collectionView.reloadData()
        }
    }
}

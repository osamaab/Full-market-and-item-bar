//
//  SearchFieldType.swift
//  talabyeh
//
//  Created by Hussein Work on 20/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import Foundation
import UIKit.UITextField

/**
 A  generic type that specifies the type of input used, with specific identifier
 */
protocol SearchFieldType: ExpandableItem {
   
    var identifier: String { get }
    
    /**
     The placeholder for the input type
     */
    var placeholder: String? { get }
}

class BaseSearchFieldType: ExpandableItem, SearchFieldType {
    var placeholder: String?
    
    init(placeholder: String? = nil){
        self.placeholder = placeholder
        super.init()
    }
}

class TextSearchFieldType: BaseSearchFieldType {

}

class LocationSearchFieldType: BaseSearchFieldType {
    
}

class CategoryPickerFieldType: BaseSearchFieldType {
    
}



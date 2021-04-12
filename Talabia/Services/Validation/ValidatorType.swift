//
//  ValidatorType.swift
//  talabyeh
//
//  Created by Hussein Work on 11/12/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import Foundation
import UIKit.UITextField


protocol ValidatorType {
    func validated(_ input: String?) throws -> String
}

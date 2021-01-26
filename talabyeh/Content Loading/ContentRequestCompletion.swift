//
//  ContentRequestCompletion.swift
//  talabyeh
//
//  Created by Hussein Work on 05/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

typealias ContentRequestCompletion<ContentType> = ((Result<ContentType, Error>) -> Void)

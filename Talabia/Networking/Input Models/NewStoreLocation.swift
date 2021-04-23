//
//  NewStoreLocation.swift
//  talabyeh
//
//  Created by Hussein Work on 14/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

struct NewStoreLocation {
    
    // if you perform an edit, use the id..
    let id: Int?
    
    let name: String
    let lat: String
    let lng: String

    let streetName: String
    let buildingName: String
    let floor: String
    let additionalDirections: String
    
    
    let allowDelivery: Bool?
    let allowPickup: Bool?
    let phones: [PhoneInput]?
    let fax: [FaxInput]?
    let emails: [EmailInput]?
    let coveringAreas: [CoveringAreaInput]?
    let workingDays: [WorkingDayInput]?
    
    static func resellerStoreLocation(
        id: Int?,
        name: String,
        lat: String,
        lng: String,
        streetName: String,
        buildingName: String,
        floor: String,
        additionalDirections: String,
        workingDays: [WorkingDayInput]
    ) -> NewStoreLocation {
        return .init(id: id, name: name, lat: lat, lng: lng, streetName: streetName, buildingName: buildingName, floor: floor, additionalDirections: additionalDirections, allowDelivery: nil, allowPickup: nil, phones: nil, fax: nil, emails: nil, coveringAreas: nil, workingDays: workingDays)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case lat = "lat"
        case lng = "lng"
        case streetName = "street_name"
        case name = "en_location_name"
        case buildingName = "building_name"
        case additionalDirections = "additional_directions"
        case allowDelivery = "allow_delivery"
        case allowPickup = "allow_pickup"
        case floor = "floor"
        case phones = "phones"
        case fax = "fax"
        case emails = "emails"
        case coveringAreas = "covering_areas"
        case workingDays = "working_days"
    }
}

extension NewStoreLocation: Codable { }

struct CoveringAreaInput: Codable {
    let cityId: Int

    enum CodingKeys: String, CodingKey {
        case cityId = "city_id"
    }
}

struct EmailInput {
    let email: String

    enum CodingKeys: String, CodingKey {
        case email = "email"
    }
}

struct FaxInput {
    let fax: String

    enum CodingKeys: String, CodingKey {
        case fax = "fax"
    }
}

struct PhoneInput {
    let phone: String

    enum CodingKeys: String, CodingKey {
        case phone = "phone"
    }
}

struct WorkingDayInput {
    let dayId: Int
    let timeFrom: String
    let timeTo: String

    enum CodingKeys: String, CodingKey {
        case dayId = "day_id"
        case timeFrom = "time_from"
        case timeTo = "time_to"
    }
}

extension EmailInput: Codable { }
extension PhoneInput: Codable { }
extension FaxInput: Codable { }
extension WorkingDayInput: Codable { }




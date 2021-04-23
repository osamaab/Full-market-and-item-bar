//
//  StoreLocation.swift
//  talabyeh
//
//  Created by Hussein Work on 14/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

struct StoreLocation: Codable {
    let id: Int
    let name: String
    let lat: String
    let lng: String
   
    let streetName: String
    let buildingName: String
    let floor: String
    let additionalDirections: String
    let city: CityItem?
    
    let phones: [APIPhoneItem]?
    let faxes: [APIFaxItem]?
    let emails: [APIEmailItem]?
    let workingDays: [APIWorkingDay]?
    
    let coveringAreas: [APICoveringArea]?
    let allowDelivery: Bool?
    let allowPickup: Bool?


    enum CodingKeys: String, CodingKey {
        case id = "id"
        case lat = "lat"
        case lng = "lng"
        case name = "location_name"
        case streetName = "street_name"
        case buildingName = "building_name"
        case floor = "floor"
        case additionalDirections = "additional_directions"
        case allowDelivery = "allow_delivery"
        case allowPickup = "allow_pickup"
        case city = "city"
        case phones = "phones"
        case faxes = "Faxes"
        case emails = "emails"
        case coveringAreas = "covering_areas"
        case workingDays = "working_days"
    }
}

// MARK: - CoveringArea
struct APICoveringArea: Codable {
    let id: Int
    let city: CityItem

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case city = "city"
    }
}

// MARK: - Email
struct APIEmailItem: Codable {
    let id: Int
    let email: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case email = "email"
    }
}

// MARK: - Fax
struct APIFaxItem: Codable {
    let id: Int
    let fax: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case fax = "fax"
    }
}

// MARK: - Phone
struct APIPhoneItem: Codable {
    let id: Int
    let phone: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case phone = "phone"
    }
}

// MARK: - WorkingDay
struct APIWorkingDay: Codable {
    let id: Int
    let dayId: Int
    let timeFrom: String
    let timeTo: String
    let day: APIDay

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case dayId = "day_id"
        case timeFrom = "time_from"
        case timeTo = "time_to"
        case day = "day"
    }
}

// MARK: - Day
struct APIDay: Codable, Comparable, Equatable {
    let id: Int
    let title: String
    let shortcut: String
    
    static func < (lhs: APIDay, rhs: APIDay) -> Bool {
        lhs.id < rhs.id
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case shortcut = "shortcut"
    }
}

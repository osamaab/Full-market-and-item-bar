//
//  StoreLocation+Details.swift
//  talabyeh
//
//  Created by Hussein Work on 15/02/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation


extension StoreLocation {
    struct DetailItem {
        enum Identifier: String {
            case email
            case fax
            case phone
            case workingDay
            case workingHour
        }
        
        var identifier: Identifier
        var text: String
    }
    
    func detailItems() -> [DetailItem] {
        var items: [DetailItem] = []
        
        if let emails = self.emails {
            items.append(contentsOf: emails.map {
                DetailItem(identifier: .email, text: $0.email)
            })
        }
        
        if let phones = self.phones {
            items.append(contentsOf: phones.map { DetailItem(identifier: .phone, text: $0.phone) })
        }
        
        if let faxes = self.faxes {
            items.append(contentsOf: faxes.map { DetailItem(identifier: .fax, text: $0.fax)})
        }
        
        if let workingDays = self.workingDays {
            if let minDay = workingDays.map({ $0.day }).min(),
               let maxDay = workingDays.map({ $0.day }).max() {
                let firstDay = workingDays.first!
                
                items.append(DetailItem(identifier: .workingDay, text: "\(minDay.title) - \(maxDay.title)"))
                items.append(DetailItem(identifier: .workingHour, text: "\(firstDay.timeFrom) - \(firstDay.timeTo)"))
            }
        }
        
        return items
    }
    
    func formattedAddress() -> String {
        [city?.title ?? "", streetName, buildingName, floor, additionalDirections].filter { !$0.isEmpty }.joined(separator: "\n")
    }
    
    func formattedSummary() -> String {
        var parts: [String] = []
        
        
        if let hasPickup = self.allowPickup {
            if hasPickup {
                parts.append("Available for Pickup")
            } else {
                parts.append("Not Available For Pickup")
            }
        }
        
        if let hasDelivery = self.allowDelivery {
            if hasDelivery {
                parts.append("Available For Delivery")
            } else {
                parts.append("Not Available For Delivery")
            }
        }
        
        if let coveringAreas = self.coveringAreas {
            parts.append("Delivered To:\n\(coveringAreas.map { $0.city.title }.joined(separator: ", "))")
        }
        
        return parts.joined(separator: "\n")
    }
}

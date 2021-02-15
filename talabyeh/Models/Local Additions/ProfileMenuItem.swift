//
//  ProfileMenuItem.swift
//  talabyeh
//
//  Created by Hussein Work on 17/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import Foundation
import UIKit.UIImage

typealias ActionBlock = (() -> Void)

/**
 The menu items in the profile view controller
 */
struct ProfileMenuItem: Equatable, Hashable {
    
    enum Style: Int, Equatable, Hashable, CaseIterable {
        case normal
        case highlighted
    }
    
    enum Identifier: String, CaseIterable {
        case login
        case myInformation
        case items
        case branches
        case companyProfile
        case payment
        case history
        case settings
    }
    
    static func == (lhs: ProfileMenuItem, rhs: ProfileMenuItem) -> Bool {
        lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    let identifier: Identifier
    let title: String
    let image: UIImage?
    let style: Style
    var action: (() -> Void)?
    
    init(identifier: Identifier,
         title: String,
         image: UIImage?,
         style: Style = .normal,
         action: ActionBlock? = nil){
        
        self.identifier = identifier
        self.title = title
        self.image = image
        self.style = style
        self.action = action
    }
    
    func withAction(_ action: (() -> Void)?) -> ProfileMenuItem {
        var new = self
        new.action = action
        return new
    }
}

extension ProfileMenuItem {
    static func information() -> ProfileMenuItem {
        return ProfileMenuItem(identifier: .myInformation, title: "My Information", image: .named("menu_info"), style: .highlighted)
    }
    
    static func items() -> ProfileMenuItem {
        return ProfileMenuItem(identifier: .items, title: "All Items", image: .named("menu_items"), style: .highlighted)
    }
    
    static func companyBranches() -> ProfileMenuItem {
        return .init(identifier: .branches, title: "Store location / Deliver locations", image: .named("menu_branches"))
    }
    
    static func companyProfile() -> ProfileMenuItem {
        return .init(identifier: .companyProfile, title: "Company Profile", image: .named("menu_profile"))
    }
    
    static func payment() -> ProfileMenuItem {
        return .init(identifier: .payment, title: "Payment", image: .named("menu_payment"))
    }
    
    static func history() -> ProfileMenuItem {
        return .init(identifier: .history, title: "History", image: .named("menu_history"))
    }
    
    static func settings() -> ProfileMenuItem {
        return .init(identifier: .settings, title: "Settings", image: .named("menu_preferences"))
    }
}

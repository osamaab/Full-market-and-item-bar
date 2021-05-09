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
        case imageChanged
    }
    
    enum Identifier: String, CaseIterable {
        case login
        case logout
        
        case myInformation
        case items
        case branches
        case companyProfile
        case payment
        case history
        case companyHistory
        case settings
        case password
        case editProfile
        case notification
        case favorits
        
        case coveringAreas
        case orders
        case status
        
        // settings cases
        case bannerBage
        case accountLevel
        case contctUs
        case changePassword
        case language
        case darkMode
        
        
        
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
    
    static func notification() -> ProfileMenuItem {
        return ProfileMenuItem(identifier: .notification , title: "Notifications".localization, image: .named("menu_exclamation"))
    }
    
    static func logout() -> ProfileMenuItem {
        return ProfileMenuItem(identifier: .logout, title: "Logout".localization, image: nil)
    }
    
    static func information() -> ProfileMenuItem {
        return ProfileMenuItem(identifier: .myInformation, title: "My Information".localization, image: .named("menu_info"), style: .highlighted)
    }
    
    static  func changePassword() -> ProfileMenuItem {
        return ProfileMenuItem(identifier: .password, title: "Change Password".localization, image: .named("menu_password"))
    }
    static func bannerBage() -> ProfileMenuItem {
        return .init(identifier: .bannerBage, title: "Banner page".localization, image: .named("banner_Setting"))
    }
    static func accountLevel() -> ProfileMenuItem {
        return .init(identifier: .accountLevel, title: "Account level".localization, image: .named("rate_Setting"))
    }
    static func contctUs() -> ProfileMenuItem {
        return .init(identifier: .contctUs, title: "Contact us".localization, image: .named("contactUs_Setting"))
    }
    static func language() -> ProfileMenuItem {
        return .init(identifier: .language, title: "Language".localization, image: .named("Lan_Setting"), style: .imageChanged);
    }
    static func darkMode() -> ProfileMenuItem {
        return .init(identifier: .darkMode, title: "Dark mood".localization, image: .named("Mode_Setting"))
    }
    
    static func items() -> ProfileMenuItem {
        return ProfileMenuItem(identifier: .items, title: "All Items".localization, image: .named("menu_items"), style: .highlighted)
    }
    
    static func companyBranches() -> ProfileMenuItem {
        return .init(identifier: .branches, title: "Deliver locations".localization, image: .named("menu_branches"))
    }
    
    static func resellerBranches() -> ProfileMenuItem {
        return .init(identifier: .branches, title: "Store/ Storage location".localization, image: .named("menu_location"))
    }
    
    static func companyProfile() -> ProfileMenuItem {
        return .init(identifier: .companyProfile, title: "Company Profile".localization, image: .named("menu_profile"))
    }
    
    static func payment() -> ProfileMenuItem {
        return .init(identifier: .payment, title: "Payment".localization, image: .named("menu_payment"))
    }
    
    static func history() -> ProfileMenuItem {
        return .init(identifier: .history, title: "Orders History".localization, image: .named("menu_orders"))
    }
    
    static func companyHistory() -> ProfileMenuItem {
        return .init(identifier: .companyHistory, title: "History".localization, image: .named("menu_history"))
    }
    
    static func favorits() -> ProfileMenuItem {
        return .init(identifier: .companyHistory, title: "Favorites".localization, image: .named("menu_favorit"))
    }
    
    static func settings() -> ProfileMenuItem {
        return .init(identifier: .settings, title: "Welcome".localization, image: .named("menu_preferences"))
    }
}



//MARK: Company Distributor Specific
extension ProfileMenuItem {
    
    // full information -> exists
    // history -> exists
    
    // covering areas
    static func coveringAreas() -> ProfileMenuItem {
        return .init(identifier: .coveringAreas, title: "Covering Areas".localization, image: .named("menu_areas"))
    }
    
    // orders
    static func orders() -> ProfileMenuItem {
        return .init(identifier: .orders, title: "Orders".localization, image: .named("menu_orders"))
    }
    
    // status
    static func status() -> ProfileMenuItem {
        return .init(identifier: .status, title: "Status".localization, image: .named("menu_status"))
    }
}
// MARK:- Profile Settings Specific
extension ProfileMenuItem {
   
}

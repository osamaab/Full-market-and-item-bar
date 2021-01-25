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
struct ProfileMenuItem {
    enum Style: Int, CaseIterable {
        case normal
        case highlighted
    }
    
    
    let title: String
    let image: UIImage?
    let style: Style
    var action: (() -> Void)?
    
    init(title: String, image: UIImage?, style: Style = .normal, action: ActionBlock? = nil){
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
    
    
    
    static func changePassword(_ action: ActionBlock? = nil) -> ProfileMenuItem {
        return .init(title: "Change Password".localiz(), image: UIImage(named: "lock"), action: action)
    }
    
    static func payment(_ action: ActionBlock? = nil) -> ProfileMenuItem {
        return .init(title: "Payment".localiz(), image: UIImage(named: "payment_card"), action: action)
    }
    
    static func orders(_ action: ActionBlock? = nil) -> ProfileMenuItem {
        return .init(title: "Orders".localiz(), image: UIImage(named: "orders_list"), action: action)
    }
    
    static func location(_ action: ActionBlock? = nil) -> ProfileMenuItem {
        return .init(title: "Store Location".localiz(), image: UIImage(named: "pin_menu"), action: action)
    }
    
    static func information(_ action: ActionBlock? = nil) -> ProfileMenuItem {
        return .init(title: "Full Information".localiz(), image: UIImage(named: "payment_card"), action: action)
    }
    
    static func history(_ action: ActionBlock? = nil) -> ProfileMenuItem {
        return .init(title: "History".localiz(), image: UIImage(named: "calendar_menu"), action: action)
    }
}

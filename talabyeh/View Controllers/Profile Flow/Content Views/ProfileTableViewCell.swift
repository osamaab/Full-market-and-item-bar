//
//  ProfileTableViewCell.swift
//  talabyeh
//
//  Created by Hussein Work on 11/11/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit
import Stevia
import LanguageManager_iOS


class ProfileTableViewCell: UITableViewCell{
    
    let icon = UIImageView()
    let label = UILabel()
    let arrow = UIImageView()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        selectionStyle = .none
        backgroundColor = UIColor(named: "Light Grey Adaptive")
        
        subviews([icon, label, arrow])
        
        icon.leading(16).height(44).width(44).centerVertically()
        label.font = LanguageManager.shared.currentLanguage == .en ? getEnglishFont(16, .medium) : getArabicFont(16, .regular)
        label.textColor = UIColor(named: "Black Adaptive")
        label.height(19).centerVertically()
        label.Leading == icon.Trailing + 8
        
        let isLight: Bool
        
        if #available(iOS 12.0, *) {
            isLight = self.traitCollection.userInterfaceStyle == .light
        } else {
            isLight = true
        }
        
        if !isLight {
            let icon = UIImage(named: "right-arrow")
            arrow.image = icon
            arrow.image = arrow.image?.withRenderingMode(.alwaysTemplate)
            arrow.tintColor = .white
        } else {
            arrow.image = UIImage(named: "right-arrow")
            
        }
        
        arrow.image = UIImage(named: "right-arrow")
        arrow.contentMode = .scaleAspectFit
        arrow.trailing(16).height(12).width(12).centerVertically()
        
        if LanguageManager.shared.currentLanguage == .ar{
            arrow.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
    }
}

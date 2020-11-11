//
//  ProfilePageView.swift
//  talabyeh
//
//  Created by Loai Elayan on 10/25/20.
//  Copyright © 2020 Converged Technology. All rights reserved.
//

import UIKit
import Stevia
import LanguageManager_iOS

class ProfilePageView: UIView {

    let headerView = UIView()
    let headerLabel = UILabel()
    let backButton = UIButton()
    let editButton = UIButton()
    
    let personalInfoView = UIView()
    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let phoneNumberLabel = UILabel()
    
    let listTableView = UITableView()
    
    convenience init() {
        
        self.init(frame:CGRect.zero)
        backgroundColor = DefaultColorsProvider.background

        defaultLayout()
    }
    
    final private func defaultLayout()
    {
        
        subviews([headerView, personalInfoView, listTableView])
        
        // main subviews
        headerView.backgroundColor = Constants.darkGreen
        headerView.leading(0).trailing(0).top(0).height(88.09)
        
        personalInfoView.backgroundColor = DefaultColorsProvider.background
        
        
        personalInfoView.leading(0).trailing(0).height(259.91)
        personalInfoView.Top == headerView.Bottom
        
        listTableView.backgroundColor = UIColor(named: "Light Grey Adaptive")
        listTableView.leading(0).trailing(0).bottom(0)
        listTableView.Top == personalInfoView.Bottom
        
        // header view
        headerView.subviews([headerLabel, backButton,editButton])
        headerLabel.font = .font(for: .heavy, size: 17)
        headerLabel.textColor = Constants.whiteText
        headerLabel.centerHorizontally().bottom(12.67).height(20)
        
        backButton.setImage(UIImage(named: "Path 769"), for: .normal)
        if LanguageManager.shared.currentLanguage == .ar{
            backButton.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
        backButton.leading(16).width(22.02).height(13.66)
        backButton.CenterY == headerLabel.CenterY
        
        editButton.setImage(UIImage(named: "Group 1413"), for: .normal)
        editButton.trailing(11.09).height(20).width(17.72)
        editButton.CenterY == headerLabel.CenterY
        
        // personal info view
        personalInfoView.subviews([profileImageView, nameLabel, emailLabel, phoneNumberLabel])
        profileImageView.height(106).width(106).centerHorizontally().top(22.94) //
        profileImageView.layer.borderWidth = 2 //
        profileImageView.layer.borderColor =  #colorLiteral(red: 0.4980392157, green: 0.5647058824, blue: 0.5098039216, alpha: 1) //
        profileImageView.layer.cornerRadius = 53//profileImageView.layer.frame.width / 2
        
        nameLabel.font = .font(for: .heavy, size: 22)
        nameLabel.textColor = UIColor(named: "Black Adaptive")
        nameLabel.centerHorizontally().height(26)
        nameLabel.Top == profileImageView.Bottom + 10
        
        let isLight: Bool
        
        if #available(iOS 12.0, *) {
            isLight = self.traitCollection.userInterfaceStyle == .light
        } else {
            isLight = true
        }
        
        emailLabel.font = .font(for: .heavy, size: 16)
        emailLabel.textColor = !isLight ? .white : #colorLiteral(red: 0.4980392157, green: 0.5647058824, blue: 0.5098039216, alpha: 1)
        emailLabel.height(19).centerHorizontally()
        emailLabel.Top == nameLabel.Bottom + 10.41
        
        phoneNumberLabel.font = .font(for: .regular, size: 13)
        phoneNumberLabel.textColor = !isLight ? .white : #colorLiteral(red: 0.4980392157, green: 0.5647058824, blue: 0.5098039216, alpha: 1)
        phoneNumberLabel.height(15).centerHorizontally()
        phoneNumberLabel.Top == emailLabel.Bottom + 14.41
    }
}



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
        
        //self.accessoryView  = UIImageView(image: UIImage(named: "right-arrow"))
        backgroundColor = UIColor(named: "Light Grey Adaptive")//Constants.lightGrey
        
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
        }else{
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

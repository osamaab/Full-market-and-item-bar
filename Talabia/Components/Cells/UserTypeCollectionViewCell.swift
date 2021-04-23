//
//  UserTypeCollectionViewCell.swift
//  talabyeh
//
//  Created by Hussein Work on 07/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

class UserTypeCollectionViewCell: UICollectionViewCell {
    
    let containerStackView: UIStackView = .init()
    let imageView: UIImageView = .init()
    let dividerView: DividerView = .init(axis: .vertical)
    let titleLabel: UILabel = .init()
    let checkedMarkImage : UIImageView = {
        let checkedMarkImage = UIImageView()
        checkedMarkImage.backgroundColor = .clear
        checkedMarkImage.image = UIImage(named: "check_empty")
        checkedMarkImage.clipsToBounds = true
        checkedMarkImage.contentMode = .scaleAspectFit
        return checkedMarkImage
    }()
    
    var isselected: Bool {
        false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        layer.cornerRadius = 20
        clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFit
        titleLabel.font = .font(for: .bold, size: 17)
        titleLabel.textColor = DefaultColorsProvider.tintPrimary
        
        dividerView.backgroundColor = DefaultColorsProvider.tintPrimary
        dividerView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        containerStackView.axis(.horizontal)
            .spacing(15)
            .alignment(.center)
            .distribution(.fill)
            .preparedForAutolayout()
        
        addSubview(containerStackView)
        containerStackView.fillHorizontally(padding: 20)
        containerStackView.fillVertically(padding: 20)
        
        
        containerStackView.addingArrangedSubviews {
            imageView
            dividerView
            titleLabel
            checkedMarkImage
            
        }
        
        dividerView.height(100%)
        imageView.width(30).height(30)
        checkedMarkImage.CenterY == imageView.CenterY
        checkedMarkImage.trailing(43)
        checkedMarkImage.width(22).height(22)
        
        setSelected(false, animated: false)
    }
    
    func setSelected(_ selected: Bool, animated: Bool){
        let block = {
            self.backgroundColor = selected ? DefaultColorsProvider.tintSecondary : DefaultColorsProvider.containerBackground3
        }
        
        if animated {
            UIView.animate(withDuration: 0, animations: block)
        } else {
            block()
        }
    }
}


extension UserTypeCollectionViewCell: CLComponentPreview {
    static var groupIdentifier: CLComponentGroupIdentifier {
        .cells
    }
    
    static func render(in context: CLComponentPreviewContext) {
        let view: Self = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        context.containerView.addSubview(view)
        
        view.imageView.image = UserType.company.image
        view.titleLabel.text = UserType.company.title
        view.isSelected = true
        
        view.top(20).bottom(20)
        view.leading(20)
        view.centerHorizontally()
    }
}

extension UserTypeCollectionViewCell {
    func updateCheckStatus(status: UIImage){
        
    }
}


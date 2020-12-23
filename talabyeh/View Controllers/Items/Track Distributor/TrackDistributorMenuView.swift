//
//  TrackDistributorMenuView.swift
//  talabyeh
//
//  Created by Hussein Work on 22/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import DropDown

class TrackDistributorMenuView: UIControl {
    
    enum Option: String, CaseIterable {
        case changeDistributor
        case callDistributor
        case smsDistributor
        
        var title: String {
            switch self {
            case .changeDistributor:
                return "Change Distributor"
            case .callDistributor:
                return "Call Distributor"
            case .smsDistributor:
                return "SMS Distributor"
            }
        }
    }
    
    var containerView: UIView = .init()
    
    let imageView: UIImageView = .init()
    let titleLabel: UILabel = .init()
    let menuButton: UIButton = .init()
    
    let menuAnchorView: UIView = .init()
    
    fileprivate var dropdown: DropDown = .init()
    
    var options: [Option] = Option.allCases
    var selectedIndex: Int?
    
    var selectedOption: Option? {
        guard let selectedIndex = selectedIndex else {
            return nil
        }
        
        return options[selectedIndex]
    }
    
    init(){
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup() {
        backgroundColor = DefaultColorsProvider.background1
        
        subviewsPreparedAL {
            containerView
            menuAnchorView
        }
        
        containerView.height(50)
        containerView.fillHorizontally(padding: 15)
        containerView.fillVertically(padding: 25)
        
        let stackView: UIStackView = .init()
        stackView.distribution(.fill)
            .alignment(.center)
            .spacing(15)
            .axis(.horizontal)
        
        containerView.subviewsPreparedAL {
            stackView
        }
        
        stackView.addingArrangedSubviews {
            imageView
            titleLabel
            menuButton
        }
        
        stackView.fillHorizontally(padding: 20)
        stackView.fillVertically(padding: 10)
        
        imageView.width(30).height(30)
        menuButton.width(25).height(18)
        
        menuButton.tintColor = DefaultColorsProvider.darkerTint
        menuButton.setImage(UIImage(named: "menu_small"), for: .normal)
        
        imageView.tintColor = DefaultColorsProvider.darkerTint
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Group 2106")
        
        titleLabel.font = .font(for: .bold, size: 22)
        titleLabel.textColor = DefaultColorsProvider.darkerTint
        titleLabel.text = "Hussein AlRyalat"
        
        
        containerView.backgroundColor = DefaultColorsProvider.background1
        containerView.layer.cornerRadius = 10
        containerView.dropShadow(color: UIColor.lightGray,
                                 opacity: 0.16,
                                 offSet: .init(width: 0, height: 3.4),
                                 radius: 3.4)
        
        setupDropdownMenu()
        
        menuButton.add(event: .touchUpInside) { [unowned self] in
            self.sendActions(for: .valueChanged)
            self.dropdown.show()
        }
        
        menuAnchorView.backgroundColor = .clear
        menuAnchorView.bottom(0).leading(0).trailing(0).height(1)
    }
    
    func setupDropdownMenu(){
        dropdown.anchorView = menuAnchorView
        dropdown.dataSource = options.map { $0.title }
        dropdown.width = UIScreen.main.bounds.width - 50
        dropdown.setupCornerRadius(15)
        dropdown.backgroundColor = DefaultColorsProvider.background
        dropdown.direction = .bottom
        dropdown.cornerRadius = 10
        dropdown.hidesOnSelection = false
        
        dropdown.cellClass = DropdownSelectionItemView.self
        dropdown.customCellConfiguration = { [unowned self] (index: Index, item: String, cell: DropDownCell) -> Void in
           
            guard let cell = cell as? DropdownSelectionItemView else { return }
            
            let item = self.options[index]
            
            cell.titleLabel.text = item.title
            cell.setSelected(index == selectedIndex, animated: false)
        }

        // Action triggered on selection
        dropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.selectedIndex = index
            self.sendActions(for: .valueChanged)
            
            let otherRows = Set([1,2,3]).filter { $0 != index }
            
            self.dropdown.selectRow(index)
            self.dropdown.deselectRows(at: otherRows)
        }
    }
    
    func hideMenu(){
        self.dropdown.hide()
        self.selectedIndex = nil
    }
}

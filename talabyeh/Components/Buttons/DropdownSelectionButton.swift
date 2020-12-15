//
//  DropdownSelectionButton.swift
//  talabyeh
//
//  Created by Hussein Work on 01/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import DropDown
import Stevia

protocol ChoiceItemType {
    var id: String { get }
    var title: String { get }
}

struct AnyChoiceItem: ChoiceItemType {
    
    let title: String
    let id: String
    
    init<T: ChoiceItemType>(item: T){
        self.title = item.title
        self.id = item.id
    }
    
    init(id: String, title: String){
        self.title = title
        self.id = id
    }
    
    init(title: String){
        self.title = title
        self.id = title
    }
}


class DropdownSelectionButton<ChoiceItem: ChoiceItemType>: RoundedButton {
    
    var choices: [ChoiceItem] {
        didSet {
            dropdown.dataSource = choices.map { $0.title }
        }
    }
    
    var selectedItem: ChoiceItem? {
        guard let selectedIndex = selectedIndex else {
            return nil
        }
        
        return choices[selectedIndex]
    }
    
    var selectedIndex: Int? {
        didSet {
            updateSelectionState()
        }
    }
        
    fileprivate var dropdown: DropDown = .init()
    
    
    init(choices: [ChoiceItem], selectedChoice: ChoiceItem? = nil){
        self.choices = choices
        self.selectedIndex = choices.firstIndex { $0.id == selectedChoice?.id }
        
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup(){
        backgroundColor = DefaultColorsProvider.background
        setTitleColor(DefaultColorsProvider.darkerTint, for: .normal)
        titleLabel?.font = .font(for: .semiBold, size: 16)
        
        setupSelectionDropdown()
        updateSelectionState()
        
        addTarget(self, action: #selector(onTap), for: .touchUpInside)
    }
    
    func setupSelectionDropdown(){
        dropdown.anchorView = self
        dropdown.dataSource = choices.map { $0.title }
        dropdown.width = UIScreen.main.bounds.width - 50
        dropdown.setupCornerRadius(15)
        dropdown.backgroundColor = DefaultColorsProvider.background
        
        
        dropdown.cellClass = DropdownSelectionItemView.self
        dropdown.customCellConfiguration = { [unowned self] (index: Index, item: String, cell: DropDownCell) -> Void in
           
            guard let cell = cell as? DropdownSelectionItemView else { return }
            
            let item = self.choices[index]
            cell.titleLabel.text = item.title
        }

        // Action triggered on selection
        dropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.selectedIndex = index
            self.sendActions(for: .valueChanged)
            
            self.dropdown.hide()
            self.dropdown.reloadAllComponents()
        }
    }
    
    func updateSelectionState(){
        self.backgroundColor = selectedIndex == nil ? DefaultColorsProvider.background : DefaultColorsProvider.darkerTint
        self.setTitleColor(selectedIndex == nil ? DefaultColorsProvider.darkerTint : DefaultColorsProvider.background, for: .normal)
    }
    
    @objc func onTap(){
        dropdown.show()
    }
}

class DropdownSelectionItemView: DropDownCell {
    
    let titleLabel: UILabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .font(for: .medium, size: 15)
    }
    
    let checkboxView: CheckboxView = CheckboxView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        contentView.addSubview(titleLabel)
        contentView.addSubview(checkboxView)
        
        checkboxView.isHidden = true
        titleLabel.leading(15).centerVertically().top(<=10)
        checkboxView.trailing(15).centerVertically().width(20).height(20)
        
        titleLabel.Trailing <= checkboxView.Leading
        self.optionLabel = titleLabel
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        titleLabel.font = selected ? .font(for: .bold, size: 15) : .font(for: .medium, size: 15)
        checkboxView.isHidden = !selected
        checkboxView.isSelected = selected
    }
}

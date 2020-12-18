//
//  SortAndFilterCollectionReusableView.swift
//  talabyeh
//
//  Created by Hussein Work on 18/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

class SortAndFilterCollectionReusableView: UICollectionReusableView {
    
    struct FilterOption: ChoiceItemType {
        var id: String
        var title: String
    }
    
    struct SortOption: ChoiceItemType {
        var id: String
        var title: String
    }
    
    let stackView: UIStackView = .init()
    
    let filterButton: DropdownSelectionButton<FilterOption> = .init(choices: [])
    let sortButton: DropdownSelectionButton<SortOption> = .init(choices: [])
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        addSubview(stackView)
        
        stackView.alignment(.fill)
            .distribution(.fillEqually)
            .spacing(15)
            .axis(.horizontal)
            .preparedForAutolayout()
        
        stackView.fillContainer()
        
        sortButton.setTitle("Sort", for: .normal)
        filterButton.setTitle("Filter", for: .normal)
        
        stackView.addingArrangedSubviews {
            filterButton
            sortButton
        }
    }
}

//
//  BigSegmentedControl.swift
//  talabyeh
//
//  Created by Hussein Work on 22/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

/**
 A type of segmented control
 */
class BigSegmentedControl: UIControl {
    
    private let stackView: UIStackView = .init()
    
    private var itemViews: [ItemView] {
        stackView.arrangedSubviews.compactMap { $0 as? ItemView }
    }
    
    var items: [String] {
        didSet {
            self.relayoutItems()
        }
    }
    
    var selectedItem: String? {
        guard let index = self.selectedIndex, index < items.count, index >= 0 else {
            return nil
        }
        
        return items[index]
    }
    
    fileprivate(set) var selectedIndex: Int?

    init(items: [String]) {
        self.items = items
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setup(){
        addSubview(stackView)
    
        stackView.distribution(.fillEqually)
            .alignment(.fill)
            .axis(.horizontal)
            .spacing(8)
            .preparedForAutolayout()

        stackView.fillContainer()
        relayoutItems()
    }
    
    func relayoutItems(){
        // remove all the views
        stackView.arrangedSubviews.forEach {
            stackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        
        // map the titles to views
        let views = items.map {
            ItemView(title: $0)
        }
        
        views.forEach { itemView in
            stackView.addArrangedSubview(itemView)
            
            itemView.addAction {
                self.viewTappeed(view: itemView)
            }
        }
    }
    
    func select(index: Int, animated: Bool){
        guard index < items.count, index >= 0 else {
            return
        }
        
        let view = self.itemViews[index]
        
        self.selectedIndex = index
        
        let block = { [unowned self] in
            self.itemViews.forEach {
                $0.isSelected = view == $0
            }
        }

        if animated {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.beginFromCurrentState, .allowAnimatedContent, .allowUserInteraction], animations: block, completion: nil)
        } else {
            block()
        }
    }
    
    private func viewTappeed(view: ItemView){
        self.select(index: itemViews.firstIndex(of: view)!, animated: true)
        self.sendActions(for: .valueChanged)
    }
}

private class ItemView: UIView {
    
    let titleLabel: UILabel = .init()
    
    var isSelected: Bool = false {
        didSet {
            backgroundColor = isSelected ? DefaultColorsProvider.lightTint : DefaultColorsProvider.darkerItemBackground
        }
    }
    
    init(title: String) {
        self.titleLabel.text = title
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        
        titleLabel.fillContainer(padding: 20)
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        
        titleLabel.font = .font(for: .semiBold, size: 17)
        titleLabel.textColor = DefaultColorsProvider.darkerTint
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        
        layer.cornerRadius = 12
    }
}

//
//  OrdersContainerViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 10/03/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

class OrdersContainerViewController: ContentViewController<String> {
   
    
    fileprivate(set) lazy var headerScrollView: HorizontalScrollContainerView = .init(contentView: segmentedControl)
    fileprivate(set) lazy var segmentedControl = OrdersHeaderView(items: [])
    fileprivate(set) lazy var viewControllers: [UIViewController] = []
    
    override var requiresAuthentication: Bool {
        true
    }
    
    convenience init(){
        self.init(contentRepository: ConstantContentRepository(content: "Hello :))"))
    }

    override func setupViewsBeforeTransitioning() {
        view.backgroundColor = DefaultColorsProvider.backgroundSecondary
        view.willRemoveSubview(headerScrollView)
        view.addSubview(headerScrollView)
        
        headerScrollView.scrollView.showsHorizontalScrollIndicator = false
        headerScrollView.Top == view.safeAreaLayoutGuide.Top + 20
        headerScrollView.leading(20).trailing(20)//.height(40)
        
        
        segmentedControl.select(index: 0, animated: false)
        
        segmentedControl.add(event: .valueChanged){ [unowned self] in
            self.select(index: segmentedControl.selectedIndex ?? 0, retryIfNeeded: true)
        }
        
        
        self.add(viewController: BaseOrdersListViewController(), for: "Received")
        self.add(viewController: BaseOrdersListViewController(), for: "Processing")
        self.add(viewController: BaseOrdersListViewController(), for: "Delivered")
        
        self.select(index: 0, retryIfNeeded: false)
    }
    
    func add(viewController: UIViewController, for title: String) {
        viewControllers.append(viewController)
        segmentedControl.insert(title: title)
        
        addChild(viewController)
        
        view.subviewsPreparedAL {
            viewController.view!
        }
        
        [viewController.view!].forEach {
            $0.Top == headerScrollView.Bottom + 20
            $0.Bottom == view.safeAreaLayoutGuide.Bottom
            $0.Leading == view.Leading
            $0.Trailing == view.Trailing
        }
        
        viewController.didMove(toParent: self)
    }
    
    func select(index: Int, retryIfNeeded: Bool){
        self.viewControllers.enumerated().forEach {
            $0.element.view.isHidden = $0.offset != index
        }
        
        guard retryIfNeeded else { return }
        
        // retry the view controller itself..
    }
}


class OrdersHeaderView: UIControl {
    
    class Button: RoundedButton {
        override var isSelected: Bool {
            didSet {
                self.backgroundColor = isSelected ? DefaultColorsProvider.tintPrimary : DefaultColorsProvider.backgroundPrimary
                self.setTitleColor(isSelected ? DefaultColorsProvider.backgroundPrimary : DefaultColorsProvider.textSecondary1, for: .normal)
            }
        }
        
        func setSelected(_ selected: Bool, animated: Bool) {
            if animated {
                UIView.animate(withDuration: 0.3) {
                    self.isSelected = selected
                }
            } else {
                self.isSelected = selected
            }
        }
        
        init(title: String){
            super.init(frame: .zero)
            setup()
            setTitle(title, for: .normal)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func setup(){
            super.setup()
            dropShadow(color: UIColor.lightGray, opacity: 0.16, offSet: .init(width: 0, height: 1), radius: 1)
            contentEdgeInsets = .init(top: 5, left: 15, bottom: 5, right: 15)
            self.isSelected = false
        }
    }
        
    private var itemViews: [Button] {
        stackView.arrangedSubviews.compactMap { $0 as? Button }
    }
    
    fileprivate(set) var items: [String]
    
    var selectedItem: String? {
        guard let index = self.selectedIndex, index < items.count, index >= 0 else {
            return nil
        }
        
        return items[index]
    }
    
    let stackView: UIStackView = .init()
    
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
    
        stackView.distribution(.fill)
            .alignment(.fill)
            .axis(.horizontal)
            .spacing(8)
            .preparedForAutolayout()

        stackView.fillContainer()
        relayoutItems()

        
        if items.count > 0 {
            self.select(index: 0, animated: false)
        }
    }
    
    fileprivate func relayoutItems(){
        // remove all the views
        stackView.arrangedSubviews.forEach {
            stackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        
        // map the titles to views
        let views = items.map {
            Button(title: $0)
        }
        
        views.forEach { itemView in
            stackView.addArrangedSubview(itemView)
            
            itemView.add(event: .touchUpInside) {
                self.viewTappeed(view: itemView)
            }
        }
    }
    
    fileprivate func viewTappeed(view: Button){
        self.select(index: itemViews.firstIndex(of: view)!, animated: true)
        self.sendActions(for: .valueChanged)
    }
    
    func insert(title: String){
        let button = Button(title: title)
        
        button.add(event: .touchUpInside) {
            self.viewTappeed(view: button)
        }
        
        self.items.append(title)
        
        stackView.addArrangedSubview(button)
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
    

}

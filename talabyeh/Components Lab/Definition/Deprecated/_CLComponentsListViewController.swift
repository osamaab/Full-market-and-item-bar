//
//  CLComponentsListViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 18/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit
import Stevia

//class _CLComponentsListViewController: UIViewController {
//    
//    lazy var scrollView: ScrollContainerView = .init(contentView: containerStackView)
//    lazy var containerStackView: UIStackView = .init()
//    
//    fileprivate(set) var components: [CLComponentItem]
//    
//    init(components: [CLComponentItem] = []){
//        self.components = components
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//        setupContainerView()
//        reRenderAllComponents()
//    }
//    
//    fileprivate func setupContainerView(){
//        view.backgroundColor = DefaultColorsProvider.background1
//        
//        containerStackView
//            .distribution(.fill)
//            .alignment(.fill)
//            .spacing(8)
//            .preparedForAutolayout()
//
//        view.subviewsPreparedAL {
//            scrollView
//        }
//        
//        scrollView.Top == view.safeAreaLayoutGuide.Top + 20
//        scrollView.left(20).right(20).bottom(0)
//    }
//}
//
//extension _CLComponentsListViewController {
//    func registerDefaultComponents(){
//        register(attributes: [.customPositioning]) { () -> UIView in
//            let view = RoundedFillButton()
//            view.contentEdgeInsets = .init(top: 8, left: 20, bottom: 8, right: 20)
//            view.setTitle("Tap meeee", for: .normal)
//            return view
//        }
//    }
//    
//    func registerComponent(item: CLComponentItem){
//        components.append(item)
//    }
//    
//    
//    @discardableResult
//    func register(attributes: [CLComponentAttribute], for factory: @escaping CLComponentItem.ComponentViewFactory) -> CLComponentItem {
//        register(name: "", attributes: attributes + [.useClassName], for: factory)
//    }
//    
//    
//    @discardableResult
//    func register(name: String, attributes: [CLComponentAttribute], for factory: @escaping CLComponentItem.ComponentViewFactory) -> CLComponentItem {
//        let item =  CLAnyComponentItem(name: name, attributes: attributes, factory: factory)
//        
//        self.registerComponent(item: item)
//        
//        return item
//    }
//    
//    func reRenderAllComponents(){
//        containerStackView.arrangedSubviews.forEach {
//            containerStackView.removeArrangedSubview($0)
//            $0.removeFromSuperview()
//        }
//        
//        components.forEach {
//            self.renderComponent($0)
//        }
//    }
//    
//    func renderComponent(_ component: CLComponentItem){
//        var view = component.generateComponentView()
//        let originanlName = type(of: view).identifier
//        
//        let preAttributes = component.attributes.filter { $0.renderPosition == .preAdding }
//        preAttributes.forEach {
//            view = $0.render(for: view)
//        }
//        
//        let containerView = CLComponentContainerView(title: component.name, contentView: view)
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//        
//        // render the attributes for the component view
//        let afterAttributes = component.attributes.filter { $0.renderPosition == .afterAdding }
//        afterAttributes.forEach {
//            $0.render(for: view)
//            
//            if case .useClassName = $0 {
//                containerView.title = originanlName
//            }
//        }
//        
//        containerStackView.addArrangedSubview(containerView)
//    }
//}

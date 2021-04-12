//
//  MarketChooseLocationViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 09/03/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia
import SwiftEntryKit

enum DeliveryType {
    case pickup
    case delivery(StoreLocation)
}

protocol MarketChooseLocationViewControllerDelegate: class {
    func marketChooseLocationViewController(sender: MarketChooseLocationViewController, didFinishWith location: DeliveryType)
}

class MarketChooseLocationViewController: ContentViewController<[StoreLocation]> {
    


    let scrollView: ScrollContainerView
    let contentView: MarketChooseLocationContentView = .init()
    
    var selectedLocation: DeliveryType?
    
    weak var delegate: MarketChooseLocationViewControllerDelegate?
    
    init(selectedLocation: DeliveryType?, delegate: MarketChooseLocationViewControllerDelegate?) {
        self.selectedLocation = selectedLocation
        self.delegate = delegate
        self.scrollView = .init(contentView: self.contentView)
        super.init(contentRepository: APIContentRepositoryType<StoreLocationsAPI, [StoreLocation]>(.storeLocations))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViewsBeforeTransitioning() {
        self.view.backgroundColor = DefaultColorsProvider.backgroundSecondary
        
        self.view.subviewsPreparedAL {
            scrollView
        }
        
        scrollView.scrollView.showsVerticalScrollIndicator = false
        scrollView.fillContainer()
        view.layer.cornerRadius = 20
        
        
        contentView.closeButton.add(event: .touchUpInside) { [unowned self] in
            self.dismiss()
        }
    }
    
    override func contentRequestDidSuccess(with content: [StoreLocation]) {

        content.forEach {
            contentView.addStoreOption($0)
        }

        if let deliveryTYpe = self.selectedLocation {
            if case .delivery(let location) = deliveryTYpe {
                contentView.selectedOptionID = location.id
                contentView.updateSelection()
            } else {
                contentView.selectedOptionID = -1
                contentView.updateSelection()
            }
        }

        contentView.onSelection = { [unowned self] id in
            if id == -1 {
                self.delegate?.marketChooseLocationViewController(sender: self, didFinishWith: .pickup)
            } else {
                guard let location = (self.content?.first { $0.id == id }) else {
                    return
                }
                
                self.delegate?.marketChooseLocationViewController(sender: self, didFinishWith: .delivery(location))
            }
        }
    }
}


extension MarketChooseLocationViewController {
    func present(){
        SwiftEntryKit.display(entry: self, using: attributesForDisplaying())
    }
    
    func dismiss(){
        SwiftEntryKit.dismiss(.all)
    }
    
    func attributesForDisplaying() -> EKAttributes {
        var alertAttributes = EKAttributes()
        alertAttributes.position = .center
        alertAttributes.windowLevel = .statusBar
        alertAttributes.screenBackground = .color(color: EKColor(UIColor.black.withAlphaComponent(0.2)))
        alertAttributes.roundCorners = .all(radius: 20)
        alertAttributes.shadow = .active(with: .init(color: .init(UIColor.lightGray), opacity: 0.2, radius: 4, offset: .zero))
        
        alertAttributes.screenInteraction = .dismiss
        
        alertAttributes.displayDuration = .infinity
        alertAttributes.entryInteraction = .forward
        alertAttributes.name = String(describing: self)
        alertAttributes.hapticFeedbackType = .none
        alertAttributes.entranceAnimation = .init(translate: nil, scale: nil, fade: .init(from: 0, to: 1, duration: 0.25))
        alertAttributes.exitAnimation = .init(translate: nil, scale: nil, fade: .init(from: 0, to: 1, duration: 0.25))
        
        
        let heightSize: EKAttributes.PositionConstraints.Edge = .intrinsic
        alertAttributes.positionConstraints.size = .init(width: .ratio(value: 0.8), height: .constant(value: 350))
                
        return alertAttributes
    }
}

class MarketChooseLocationContentView: BasicViewWithSetup {
    
    
    let containerStackView: UIStackView = UIStackView().then {
        $0.alignment(.fill)
            .distribution(.fill)
            .axis(.vertical)
            .spacing(8)
    }
    
    let titleLabel = UILabel().then {
        $0.text = "Choose where you want to deliver your order"
        $0.font = .font(for: .bold, size: 21)
        $0.textColor = DefaultColorsProvider.textPrimary1
        $0.numberOfLines = 0
    }
    
    let closeButton: UIButton = UIButton().then {
        $0.tintColor = DefaultColorsProvider.textPrimary1
        $0.setImage(.named("close"), for: .normal)
    }
    
    let topSeparatorView = DividerView(axis: .horizontal)
    let bottomSeparatorView = DividerView(axis: .horizontal)
    let pickupOptionView = MarketStoreOptionView(title: "Pickup")

    var optionViews: [MarketStoreOptionView] = []
    var selectedOptionID: Int?
    
    var onSelection: ((Int) -> Void)?
    
    override func setup() {
        subviewsPreparedAL {
            closeButton
            containerStackView
        }
        
        
        pickupOptionView.add(gesture: .tap(1)) { [unowned self] in
            self.selectedOptionID = pickupOptionView.id
            self.updateSelection()
        }
        
        backgroundColor = DefaultColorsProvider.backgroundSecondary
        containerStackView.leading(20).trailing(20).bottom(15)
        containerStackView.Top == closeButton.Bottom + 15
        
        containerStackView.addingArrangedSubviews {
            titleLabel
            topSeparatorView
            bottomSeparatorView
        }
        
        containerStackView.addingArrangedSubviews {
            pickupOptionView
        }
        
        closeButton.trailing(20).top(15)
    }
    
    func addStoreOption(_ option: StoreLocation){
        let optionView = MarketStoreOptionView(title: option.name, subtitle: option.formattedAddress())
        
        self.optionViews.append(optionView)
        optionView.translatesAutoresizingMaskIntoConstraints = false
        
        optionView.id = option.id
        optionView.add(gesture: .tap(1)) { [unowned self, optionView] in
            self.selectedOptionID = optionView.id
            self.updateSelection()
            self.onSelection?(optionView.id)
        }
        
        let index = containerStackView.arrangedSubviews.firstIndex(of: bottomSeparatorView)!
        containerStackView.insertArrangedSubview(optionView, at: index)
    }
    
    func updateSelection(){
        optionViews.forEach {
            $0.checkbox.isSelected = $0.id == self.selectedOptionID
        }
        
        self.pickupOptionView.checkbox.isSelected = self.selectedOptionID == -1
    }
}

class MarketStoreOptionView: BasicViewWithSetup {
    
    
    var id: Int = -1
    
    let titleLabel = UILabel().then {
        $0.text = "Amman Market 1"
        $0.textColor = DefaultColorsProvider.tintPrimary
        $0.font = .font(for: .semiBold, size: 17)
    }
    
    let subtitleLabel = UILabel().then {
        $0.text = "Madden str. Building no 3"
        $0.textColor = DefaultColorsProvider.textSecondary1
        $0.font = .font(for: .semiBold, size: 15)
    }
    
    
    let checkbox: CheckboxView = .init()
    
    init(title: String?, subtitle: String? = nil){
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup() {
        let stackView = UIStackView()
        
        stackView.alignment(.fill)
            .distribution(.fill)
            .axis(.vertical)
            .spacing(3)
        
        stackView.addingArrangedSubviews {
            titleLabel
            subtitleLabel
        }

        subviewsPreparedAL {
            stackView
            checkbox
        }
        
        checkbox.centerVertically().leading(0).width(25).height(25)
        stackView.top(>=8).centerVertically().trailing(0)
        stackView.Leading == checkbox.Trailing + 15
    }
}

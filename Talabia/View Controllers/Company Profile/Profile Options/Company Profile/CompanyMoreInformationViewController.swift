//
//  CompanyProfileViewController.swift
//  talabyeh
//
//  Created by Hussein Work on 08/03/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

protocol CompanyMoreInformationViewControllerDelegate: AnyObject {
    func companyMoreInformationViewController(_ sender: CompanyMoreInformationViewController, didFinishWith input: CompanyAdditionalInfoInput)
}

class CompanyMoreInformationViewController: UIViewController {

    enum InputKeys: String, CaseIterable {
        case summery
        case vision
        case history
        case more
        
        var title: String {
            self.rawValue.capitalizingFirstLetter()
        }
        
        static func `for`(title: String) -> InputKeys? {
            allCases.first { $0.title == title }
        }
    }

    
    let contentView: NewDistributerContentView = .init()
    let bottomView: BottomNextButtonView = .init(title: "Save")

    weak var delegate: CompanyMoreInformationViewControllerDelegate?
    
    let certificatesView = CertificatePDFContentView()
    let profileView = ProfilePDFContentView()
    let informationInputContentView = CompanyInformationInputContentView(inputFields: InputKeys.allCases.map { $0.title })
    
    init(delegate: CompanyMoreInformationViewControllerDelegate? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = DefaultColorsProvider.backgroundSecondary
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.scrollContainerView.scrollView.contentInset.bottom += 100
        
        view.subviews {
            contentView
            bottomView
        }
        
        contentView.left(0).right(0)
        contentView.Top == view.safeAreaLayoutGuide.Top
        contentView.Bottom == view.safeAreaLayoutGuide.Bottom
        
        bottomView.right(0).left(0).bottom(0)
        setupCardViews()
        
        bottomView.nextButton.add(event: .touchUpInside) {
            let summary = self.informationInputContentView.text(for: InputKeys.summery.title)
            let vision = self.informationInputContentView.text(for: InputKeys.vision.title)
            let history = self.informationInputContentView.text(for: InputKeys.history.title)
            let more = self.informationInputContentView.text(for: InputKeys.more.title)

            let bannerImage = self.profileView.imageView.image?.toBase64()
            let certificateImage = self.certificatesView.imageView.image?.toBase64()
            
            self.delegate?.companyMoreInformationViewController(self, didFinishWith: .init(bannerB64: bannerImage, summary: summary, vision: vision, history: history, more: more, certificateB64: certificateImage))
        }
    }
    
    func setupCardViews(){
        contentView.insertCardView(with: informationInputContentView, title: "")
        contentView.insertCardView(with: profileView, title: "")
        contentView.insertCardView(with: certificatesView, title: "")
    }
}



//
//  BannerPageViewController.swift
//  Talabia
//
//  Created by Osama Abu hdba on 04/05/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import UIKit
import Stevia

protocol BannerPageViewControllerDelegate: AnyObject {
    func bannerPageViewController(_ sender: BannerPageViewController, didFinishWith image: Banner)
}
struct BannerResponse: Codable {
    let results: String?
}

struct Banner:Codable {
    let banner64: String
    enum CodingKeys: String, CodingKey {
        case banner64 = "banner_b64"
    }
}

class BannerPageViewController: UIViewController {
    
    enum ImagePickMode: Int {
        case logo
    }
    lazy var contentView = BannerPageContentView()
    lazy var bottomNextView: BottomNextButtonView = .init(title: "Save")
    weak var delegate: BannerPageViewControllerDelegate?
    fileprivate var imagePickMode: ImagePickMode = .logo
    
    var logoImage: UIImage? {
        didSet {
            updateImageView()
        }
    }
    override func viewDidLoad() {
        title = "Banner page"
        super.viewDidLoad()
        view.subviewsPreparedAL {
            contentView
            bottomNextView
        }
        contentView.Top == view.safeAreaLayoutGuide.Top + 20
        contentView.addPicButton.isEnabled = true
        bottomNextView.leading(0).trailing(0).bottom(0)
        contentView.leading(10).trailing(10)
        addActions()
    }
    
    fileprivate func addActions(){
        contentView.addPicButton.addAction {[unowned self] in
            self.imagePickMode = .logo
            let imagePicker = ImagePickerController(presentationController: self,
                                                    delegate: self)
            imagePicker.present(from: contentView.addPicButton)
        }
        self.bottomNextView.nextButton.add(event: .touchUpInside) { [unowned self] in
            
            do {
                let form = try self.updateToBase64()
                self.delegate?.bannerPageViewController(self, didFinishWith: form)
            } catch {
                self.showMessage(message: "Please fill all fields", messageType: .failure)
            }
        }
    }
    
    
    private func updateImageView(){
        contentView.imageView.image = logoImage
        
    }
    func updateToBase64() throws -> Banner{
        guard let logo = self.logoImage else {
            return Banner(banner64: "")
        }
        guard let logo64Base = logo.optimizedIfNeeded()?.toBase64() else {
            fatalError("Corrupted Image")
        }
        let imageString = Banner(banner64: logo64Base)
        
        return imageString
    }
}

extension BannerPageViewController: ImagePickerControllerDelegate {
    func editImagePickerController(_ sender: ImagePickerController, didFinishWith info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.editedImage] as? UIImage {
            switch imagePickMode {
            case .logo:
                self.logoImage = image
            }
            
        }else {
            if let image = info[.originalImage] as? UIImage {
                switch imagePickMode {
                case .logo:
                    self.logoImage = image
                }
            }
        }
    }
    
    func imagePickerController(_ sender: ImagePickerController, didFinishWith image: UIImage?) {
    }
}

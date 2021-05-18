//
//  ImagePickerController.swift
//  talabyeh
//
//  Created by Hussein Work on 11/12/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

private let cameraTitle = "Take Photo"
private let photoLibraryTitle = "Photo Library"
private let cancelTitle = "Cancel"

public protocol ImagePickerControllerDelegate: class {
    func imagePickerController(_ sender: ImagePickerController, didFinishWith image: UIImage?)
    func editImagePickerController(_ sender: ImagePickerController, didFinishWith info: [UIImagePickerController.InfoKey: Any])
}

extension ImagePickerControllerDelegate {
    func editImagePickerController(_ sender: ImagePickerController, didFinishWith info: [UIImagePickerController.InfoKey: Any]) {
    
    }
}
open class ImagePickerController: NSObject {
    
    /**
     This is not a singltone object, we just need to keep reference to the current controller, so clients can benifit without referencing the controller itself
     */
    private static var current: ImagePickerController?

    let pickerController: UIImagePickerController
    
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerControllerDelegate?

    public init(presentationController: UIViewController, delegate: ImagePickerControllerDelegate) {
        self.pickerController = UIImagePickerController()

        super.init()

        self.presentationController = presentationController
        self.delegate = delegate

        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        self.pickerController.mediaTypes = ["public.image"]
        
        type(of: self).current = self
    }

    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }

        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }

    public func present(from sourceView: UIView) {

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        if let action = self.action(for: .camera, title: cameraTitle) {
            alertController.addAction(action)
        }
        
        if let action = self.action(for: .photoLibrary, title: photoLibraryTitle) {
            alertController.addAction(action)
        }

        alertController.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: nil))

        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }

        self.presentationController?.present(alertController, animated: true)
    }

    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        self.delegate?.imagePickerController(self, didFinishWith: image)
        Self.current = nil
    }
}

extension ImagePickerController: UIImagePickerControllerDelegate {

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) { [unowned self] in
            self.pickerController(picker, didSelect: nil)
        }
    }

    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        self.delegate?.editImagePickerController(self, didFinishWith: info)
        
        guard let image = info[.originalImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil)
        }

        picker.dismiss(animated: true) { [unowned self] in
            if let editedImage = info[.editedImage] as? UIImage {
                self.delegate?.imagePickerController(self, didFinishWith: editedImage)
            } else {
                self.delegate?.imagePickerController(self, didFinishWith: image)
            }
        }
    }
}

extension ImagePickerController: UINavigationControllerDelegate { }

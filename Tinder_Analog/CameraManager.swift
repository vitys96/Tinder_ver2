//
//  CameraManager.swift
//  Tinder_Analog
//
//  Created by Vitaly on 16.10.2019.
//  Copyright © 2019 Vitaly. All rights reserved.
//

import UIKit

class CameraManager: NSObject {
    static let shared = CameraManager()
    fileprivate var imagePickedBlock: ((UIImage?) -> Void)?
    fileprivate weak var currentVC: UIViewController!
    
    func camera(button: UIButton? = nil) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let picker = CustomImagePickerController()
            picker.delegate = self
            picker.sourceType = .camera
            if let button = button {
                picker.imageButton = button
            }
            currentVC.present(picker, animated: true, completion: nil)
        }
    }
    
    func photoLibrary(button: UIButton? = nil) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = CustomImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            if let button = button {
                picker.imageButton = button
            }
            currentVC.present(picker, animated: true, completion: nil)
        }
    }
    
    func showActionSheet(vc: UIViewController, button: UIButton? = nil, completion: ((UIImage?) -> Void)? = nil) {
        imagePickedBlock = completion
        currentVC = vc
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            self.camera(button: button)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            self.photoLibrary(button: button)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        vc.present(actionSheet, animated: true, completion: nil)
    }
    
    
}
extension CameraManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        currentVC.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            let imageButton = (picker as? CustomImagePickerController)?.imageButton
            imageButton?.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            self.imagePickedBlock?(image)
        } else{
            self.imagePickedBlock?(nil)
        }
        currentVC.dismiss(animated: true, completion: nil)
    }
}

class CustomImagePickerController: UIImagePickerController {
    var imageButton: UIButton?
}

//
//  SignUpControllerExtension.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 28.07.23.
//

import UIKit

extension SignUpController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        
        if let editingImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            
            plusPhotoButton.setImage(editingImage.withRenderingMode(.alwaysOriginal), for: .normal)
            
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            plusPhotoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.black.cgColor
        plusPhotoButton.layer.borderWidth = 3
                
        dismiss(animated: true)
    }
}
